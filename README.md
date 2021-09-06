# Riposo CMD

Docker image for composing [Riposo](https://github.com/riposo/riposo) releases.

## Usage

```shell
docker run [DOCKER_RUN_OPTIONS]... ghcr.io/riposo/cmd [BUILD_OPTIONS]...
```

### Build Options

Includes all [`go build` flags](https://golang.org/cmd/go/#hdr-Compile_packages_and_dependencies) and a number of custom options:

- `--plugins` - specify the plugins to include in the build, accepts a comma-separated list of either core plugin IDs, github paths or full URLs.
- `--source` - reference the container location of the riposo source
- `--version` - specify a particular riposo version to build

### Examples

Build a `riposo` binary in your local path:

```shell
docker run --rm \
    --volume $(pwd):/dist \ # docker option: mount current host path to /dist on container
    ghcr.io/riposo/cmd \    # docker image
    -ldflags '-s -w' \      # build option: https://golang.org/pkg/cmd/link/
    -o /dist/riposo         # build option: write binary to /dist/riposo
```

Build custom version with plugins:

```shell
docker run --rm --volume $(pwd):/dist ghcr.io/riposo/cmd \
    --version v0.2.0 \
    --plugins accounts,default-bucket,github/repo,test.domain/custom/repo \
    -o /dist/riposo
```

Use custom plugin versions:

```shell
docker run --rm --volume $(pwd):/dist ghcr.io/riposo/cmd \
    --plugins accounts@v0.2.0 \
    -o /dist/riposo
```

Build from own source:

```shell
git clone https://github.com/riposo/riposo.git riposo
docker run --rm --volume $(pwd):/dist --volume $(pwd)/riposo:/riposo ghcr.io/riposo/cmd \
    --plugins accounts,flush \
    --source /riposo \
    -o /dist/riposo
```

## License

Copyright 2021 Black Square Media Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this material except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
