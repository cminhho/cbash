# Maven plugin for CBASH - Maven helpers

Maven plugin: uses `mvnw` when present in the project (current or parent directory), otherwise runs system `mvn`. Defines common Maven aliases. Behaviour is inspired by [ohmyzsh mvn plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/mvn).

Loaded automatically when you source CBASH (aliases and `mvn` wrapper are available in your shell).

## Commands

* `cbash mvn` or `cbash mvn help`: show plugin help.
* `cbash mvn list`: list Maven aliases.

## Behaviour

* **mvn / mvnw**: Typing `mvn` runs `./mvnw` if it exists in the current directory or any parent, otherwise runs `mvn` from PATH.
* **Aliases**: All aliases below use this wrapper, so they also prefer `mvnw` when present.

## Aliases

| Alias | Command |
|-------|--------|
| `mvn` | mvnw if present, else mvn |
| `mci` | mvn clean install |
| `mi` | mvn install |
| `mcp` | mvn clean package |
| `mp` | mvn package |
| `mdep` | mvn dependency:tree |
| `mpom` | mvn help:effective-pom |
| `mcisk` | mvn clean install -Dmaven.test.skip=true |
| `mcpsk` | mvn clean package -Dmaven.test.skip=true |
| `mrprep` | mvn release:prepare |
| `mrperf` | mvn release:perform |
| `mrrb` | mvn release:rollback |
| `install` | mvn clean install |
| `build` | mvn clean install -DskipTests |
| `test` | mvn test |
| `clean` | mvn clean |
| `run` | mvn spring-boot:run -Plocal |
| `run_debug_app` | mvn spring-boot:run -Plocal (with debug) |
| `mvnboot` | mvn spring-boot:run |
| `mvnqdev` | mvn quarkus:dev |

## Prerequisites

* [Maven](https://maven.apache.org/) on PATH, or use a project that provides `mvnw`.

## Examples

```bash
# In a project with mvnw
mvn clean install   # runs ./mvnw
mci                # same

# Plugin help
cbash mvn
cbash mvn list
```
