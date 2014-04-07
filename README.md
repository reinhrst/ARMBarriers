ARMBarriers
===========

This repository contains code and documents supporting my EuroLLVM 2014 talk, discussing optimising ARM barriers

The patch has been included in LLVM trunk: https://github.com/llvm-mirror/llvm/commit/421397ac00b2a83a74c78685aa22e3b640d898aa

 - report.pdf The report describing the work and conclusions in more detail
 - slides\_eurollvm\_2014.pdf The slides accomanying the talk
 - report/ source files for the report
 - results/ raw result data
 - seqlock/ seqlock benchmark, and machinecode files of different optimisations. See results/headers.txt for explanation
