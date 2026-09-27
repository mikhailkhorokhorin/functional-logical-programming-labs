FROM mcr.microsoft.com/devcontainers/base:trixie

ENV DOTNET_ROOT=/usr/share/dotnet \
    DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    DOTNET_NOLOGO=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        swi-prolog-nox \
        libicu76 \
        python3 \
        python3-venv \
        pre-commit \
        nodejs \
        npm \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh \
    && bash /tmp/dotnet-install.sh --channel 10.0 --install-dir "$DOTNET_ROOT" \
    && ln -s "$DOTNET_ROOT/dotnet" /usr/local/bin/dotnet \
    && rm /tmp/dotnet-install.sh \
    && git config --system --add safe.directory '*'
