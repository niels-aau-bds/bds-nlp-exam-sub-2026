#!/bin/bash
#SBATCH --job-name=extract
#SBATCH --output=extract_%j.out
#SBATCH --error=extract_%j.err
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --cpus-per-task=8
#SBATCH --time=06:00:00

# Ollama in its own container, on a port of its own (other jobs may share the node)
export OLLAMA_HOST=127.0.0.1:$((20000 + SLURM_JOB_ID % 10000))
export OLLAMA_MODELS=$HOME/ollama-models
export OLLAMA_NUM_PARALLEL=4
singularity exec --nv ~/ollama.sif ollama serve > ollama_$SLURM_JOB_ID.log 2>&1 &

# wait until the server answers, then download the model (only the first time)
for i in $(seq 60); do singularity exec ~/ollama.sif ollama list > /dev/null 2>&1 && break; sleep 2; done
singularity exec ~/ollama.sif ollama pull gemma4:e2b

ollama_version=$(singularity exec ~/ollama.sif ollama --version)
echo "$ollama_version"
singularity exec /ceph/container/python/python_3.10.sif python3 -m pip show openai pydantic pandas
# The extraction is saved incrementally
singularity exec /ceph/container/python/python_3.10.sif python3 extract.py