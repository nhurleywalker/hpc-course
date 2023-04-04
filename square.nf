#! /usr/bin/env nextflow

version='1.0'
date='2023-04-04'
author="Natasha Hurley-Walker"

log.info """\
         Super basic Nextflow example
         ============================
         version      : ${version} - ${date}
         author       : ${author}
         --
         run as       : ${workflow.commandLine}
         config files : ${workflow.configFiles}
         """
         .stripIndent()

numbers = Channel.from(9543..9545)

process square {

        input:
        val(number) from numbers

        output:
        file("result_${number}.txt") into results

        script:
        """
        ${params.code_dir}/square.sh ${number} > result_${number}.txt
        """
}

process concatenate {

        input:
        file results_txt from results.collect()

        output:
        file("results.txt")

        script:
        """
        cat ${results_txt} >> ${params.output_dir}/results.txt
        """
}
