# Generative AI in business research

This notebook studies themes and growth, extracts and evaluates article information, builds bibliometric networks and a knowledge graph, and tests retrieval, grounded answers and a research agent.

## Setup

Open this folder in VS Code, then open `bds_nlp_exam_sub_2026.ipynb`. The saved notebook was run with Python 3.13.5 on macOS. From the repository root:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
```

Select the environment as the notebook kernel and use the repository root as the working directory. The first run may need internet access to download models and clone the course retrieval repository. For an exact copy of a working environment, retain its installed package versions.

Place the course copy of `scopus_genai_business.csv` at the repository root. Its size is approximately 105 MiB, so the supplied Git ignore rules exclude it. Use the same corpus and article order as the saved run.

Copy the files from the final working project to `outputs/`.

| File | Role |
| --- | --- |
| `extractions.jsonl` | Saved AI-LAB extraction for the 2,000-article sample |
| `gold.csv`, `reader_a.csv`, `reader_b.csv` | Reference labels and the ratings used for agreement |
| `retrieval_judgments.csv` | Relevance judgments for the exact candidate pool in the notebook |
| `free_text_review.csv`, `claim_review.csv` | Saved evidence reviews displayed in the notebook |
| `agent_review.csv`, `agent_traces.jsonl` | Historical evaluation, before the theme lookup was revised |
| `paper_type_decisions.csv` | Saved decision-model outputs, or generate them with a compatible Ollama server |
| `pilot.jsonl`, `theme_labels.json`, `s3/`, `topics.npy`, `minilm.npy` | Saved pilot, labels and caches from the same working project, if available |

The notebook reports the historical agent scores of 5/8 for the original tool description and 2/8 for the clarified description. The files named `agent_review_normalized.csv` and `agent_traces_normalized.jsonl` belong to a separate experiment.

## Run

Start Ollama. The notebook defaults to `127.0.0.1:11434`. Prepare `gemma4:e2b`; generating decision-model outputs also requires `d3:2b` and a server supporting `/v1/systemone`.

```bash
ollama pull gemma4:e2b
ollama pull d3:2b
```

Keep the saved settings `EXTRACTION_STAGE = "load"`, `RUN_NORMALIZED_AGENT_EVAL = False` and `LAUNCH_INTERFACE = False`. Restart the kernel and run all cells. The notebook loads the saved extraction, recomputes downstream outputs, and makes a live Ollama call for the instruction-conflict test in cell 34. For a local Gradio demo, set `LAUNCH_INTERFACE = True` and run the final cell after the analysis has loaded.

The notebook generates `outputs/extract.py` and `outputs/run_extract.sh`. Matching copies are included in the repository root. The Slurm script requires the AI-LAB paths and Ollama container configured in that script.

## Submission files

Use the final report PDF, saved notebook with outputs, and the five files from the same final project: `extractions.jsonl`, `gold.csv`, `retrieval_judgments.csv`, `triples.csv`, and `knowledge_graph.graphml`. The notebook writes the last two under `outputs/`.

The GitHub starter archive contains the saved notebook, documentation, dependencies and scripts. Supply the data and review files from the final project when packaging the submission.
