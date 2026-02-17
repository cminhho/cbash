# Maven aliases for CBASH

alias mvn='mvn-or-mvnw'

# Project lifecycle
alias install='mvn clean install'
alias build='mvn clean install -DskipTests'
alias test='mvn test'
alias clean='mvn clean'
alias run='mvn spring-boot:run -Plocal'
alias run_debug_app='mvn spring-boot:run -Plocal -Drun.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=$PORT_NUMBER"'

# Short Maven aliases
alias mci='mvn clean install'
alias mi='mvn install'
alias mcp='mvn clean package'
alias mp='mvn package'
alias mrprep='mvn release:prepare'
alias mrperf='mvn release:perform'
alias mrrb='mvn release:rollback'
alias mdep='mvn dependency:tree'
alias mpom='mvn help:effective-pom'
alias mcisk='mci -Dmaven.test.skip=true'
alias mcpsk='mcp -Dmaven.test.skip=true'

# Extra ohmyzsh-style aliases
alias mvnag='mvn archetype:generate'
alias mvnboot='mvn spring-boot:run'
alias mvnc='mvn clean'
alias mvnci='mvn clean install'
alias mvncp='mvn clean package'
alias mvncom='mvn compile'
alias mvndt='mvn dependency:tree'
alias mvnp='mvn package'
alias mvnt='mvn test'
alias mvnqdev='mvn quarkus:dev'
