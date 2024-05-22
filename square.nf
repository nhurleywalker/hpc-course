#! /usr/bin/env nextflow

version='2.0'
date='2024-05-22'
author="Natasha Hurley-Walker"

nextflow.enable.dsl=2

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

workflow {
    // Define the numbers channel
    numbers = Channel.of(9543..9545)
    // Note that reading from a file is preferable to hand-editing, e.g.
    // numbers = Channel.fromPath("path/to/input.txt")

    // Execute the square process
    // Note the use of collect in order to receive all three of the outputs of this process
    resultFiles = square(numbers).collect()

    // Execute the concatenate process
    concatenate(resultFiles)

}

process square {

        input:
        val number

        output:
        file("result_${number}.txt")

        script:
        """
        ${params.code_dir}/square.sh ${number} > result_${number}.txt
        """
}

process concatenate {

        input:
        file resultFile

        // obviously terrible -- should be defined on the command line or in a parameter file
        output:
        file("results.txt")

        script:
        """
        cat ${resultFile} >> ${params.output_dir}/results.txt
        """
}
