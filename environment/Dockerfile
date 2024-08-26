# hash:sha256:23737c77dc53bfcbbf110c962584ada54a211056fd964bfea2b2942f94cd63cc
FROM registry.apps.codeocean.com/codeocean/mambaforge3:22.11.1-4-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_ASKPASS
ARG GIT_ACCESS_TOKEN
COPY git-askpass /

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        samtools=1.13-4 \
    && rm -rf /var/lib/apt/lists/*

RUN conda install -y --channel=defaults --channel=bioconda --channel=conda-forge \
        bowtie2==2.5.1 \
    && conda clean -ya

RUN pip install -U --no-cache-dir \
    code-ocean-aux-tools==1.0.9

COPY postInstall /
RUN /postInstall
