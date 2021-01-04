name_version = $(shell Rscript -e 'cat(read.dcf("DESCRIPTION")[1L, c("Package", "Version")], "\n")')
pkgname = $(firstword ${name_version})
pkgversion = $(lastword ${name_version})

bundle_name = ${pkgname}_${pkgversion}.tar.gz

# Ideally this should be resolved automatically, since R *knows* which files it
# will include inside a build. But unfortunately R currently (v4.0.1) does not
# expose this as a file list. The logic is only found in the function
# `check_file_names`, which is defined inside `tools:::.check_packages`.
source_files = \
	DESCRIPTION \
	NAMESPACE \
	LICENSE \
	.Rbuildignore \
	README.md \
	$(wildcard R/*) \
	$(wildcard tests/*) \
	$(wildcard man/*)

.PHONY: build
build: ${bundle_name}

${bundle_name}: ${source_files}
	${RM} ${bundle_name}
	R CMD build .

.PHONY: check
check: ${bundle_name}
	R CMD check --as-cran $< \
	| tee /dev/stderr \
	| grep -q '^Status: OK$$'
