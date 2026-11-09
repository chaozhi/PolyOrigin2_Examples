:;   # --- LINUX / macOS SECTION ---
:;   WORKDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
:;   cd "$WORKDIR"
:;   echo "Current directory (Linux): $(pwd)"
:;   polyorigin -g potato2x_geno.vcf.gz -p potato2x_ped.csv \
:;      --isphysmap true --recomrate 1.7 --chrsubset "[1,2]" \
:;      --outstem potato2x_out --nworker 6
:;   exit $?

@ECHO OFF
REM --- WINDOWS SECTION ---
SET "WORKDIR=%~dp0"
CD /D "%WORKDIR%"
ECHO Current directory (Windows): "%CD%"
polyorigin -g potato2x_geno.vcf.gz -p potato2x_ped.csv ^
    --isphysmap true --recomrate 1.7 --chrsubset "[1,2]" ^
    --outstem potato2x_out --nworker 6
PAUSE
