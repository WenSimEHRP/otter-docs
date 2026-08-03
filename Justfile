commit_hash_full := `git rev-parse HEAD`
package-version := `rg '^version\s*=\s*"(\d+\.\d+\.\d+)"$' -o -r '$1' typst.toml`

default:
    just --list

# build the site
build:
    ./dist.typ

# index the site
index: build
    pagefind --site ./dist --output-subdir pagefind

# watch build output
watch:
    typst watch --features bundle,html --format bundle ./dist.typ ./dist --pretty

# watch build PDF output
watch-pdf:
    typst watch --features bundle,html --format pdf ./dist.typ doc.pdf

# build the readme using pandoc
build-readme:
    nix develop .#prepareRelease --command pandoc ./readme.typ -o README.md
    cat README.md | sed \
        's#demo.avif#https://raw.githubusercontent.com/wensimehrp/haita/{{ commit_hash_full }}/demo.avif#g' \
        > MODIFIED.md
    mv MODIFIED.md README.md

# make the code release
make-release: build-readme
    rm -rf release
    mkdir -p release
    cp -r lib.typ new-hamber.typ typst.toml LICENSE README.md assets fonts scripts styles release/

# installs the release. This assumes Linux w/ XDG
install-release: make-release
    rm -rf          ~/.local/share/typst/packages/local/haita/{{ package-version }}
    mkdir -p        ~/.local/share/typst/packages/local/haita/{{ package-version }}
    cp -r release/* ~/.local/share/typst/packages/local/haita/{{ package-version }}
