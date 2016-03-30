#
# This is a command file.
#
# To make a new test, all you have to do is:
#   1.  Make a new directory under biweekly/
#   2.  Put a file like this (named "command") into that directory.
#
# The contents of this file will be passed to the shell (Bash or SSH),
# so any legal shell commands can go in this file.
# Or comments like this one, for that matter.
#
# Variable substiution is done using Python's printf format,
# meaning you need a percent sign, the variable name in parentheses,
# and the letter 's' (for 'string').
#
# Available variables include:
#   workdir     the directory where test input files have been copied,
#               and where test output files should end up.
#   minidir     the base directory where Mini lives
#   database    where the Mini database lives
#   bin         where the Mini binaries live
#   binext      the extension on binary files, like ".linuxgccrelease"
#   scfxn       a directory containing score function parameter files:
#                  flags         # a flags file
#                  weights.wts   # a weights file
#
# The most important thing is that the test execute in the right directory.
# This is especially true when we're using SSH to execute on other hosts.
# All command files should start with this line:
#

cd %(workdir)s

#Running flexpepbind protcol on three biological systems
for i in HDAC8 FTase;do
	cd $i/
	scripts/fpbind_run.sh
	scripts/fpbind_analysis.sh
	cd ../
done

for i in HDAC8 FTase;do
  cd $i
  for j  in `cat input_files/peptide.list`;do
    [ -r $j/Minimization/min.score.sc ] || exit 1
  done
  cd ../
done

#
# After that, do whatever you want.
# Here's a typical test for a Mini binary, assuming there's a "flags" file
# in this directory too:
#
# nice %(bin)s/MY_MINI_PROGRAM.%(binext)s \
#     @flags \
#     @%(scfxn)s/flags \
#     -score:weights %(scfxn)s/weights.wts \
#     -database %(database)s >&1 \
#     > files/log
#
#
# Finally create a .results.yaml file which contains results that are
# shown on the RosettaTests testing server.
#
#result_value=999
#test_passed=True
#
#sed \
#    -e "s/SCFXN/%(scfxn)s/g" \
#    -e "s/RESULT_VALUE/${result_value}/g" \
#    -e "s/IS_TEST_PASSED/${test_passed}/g" \
#    .results.yaml.TEMPLATE \
#    .results.yaml
#

