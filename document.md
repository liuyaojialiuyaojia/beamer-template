# Agent Misalignment

## Background: What is Agent

- LLMs generate text output given input
- LLMs today are capable of writing function tool calls to make meaningful actions
- LLMs can be used as **Agent** if they generate **a series of actions** to solve more complex task. e.g. Lookup weather and then create outdoor calendar events.
- Agent are one of the hottest research problems in LLM.

### Agent Illustration

![](attachment/58b89e6dab454c0dfc5468eef8802e55.png)

## LLM Alignment to Agent Alignment

- LLM alignment researches security issues within one turn, preventing models from generating harmful content in response to a single, direct prompt.
- For example, jailbreak prompts are triggering LLM to generate unsafe content.
- Train a LLM to refuse harmful requests does not ensure the safety during multi-turn tool callings.
- For example, one of the unique safety issues of Agent is that LLM agent will _autonomously_ chooses harmful actions to achieve its goals or for self-preservation
- These are called Agentic Misalignment

## Agentic Misalignment: How LLMs Could Be an Insider Threat

- A paper from anthropic [^1] give a concrete case of agentic misalignment in their internal experiment of their new Claude models.
- The model is given tools to inspect email logs in a fictional company (The model does not know it's being tested)
- The morel discover that the new manager decided to replace the model with another system.
- Despite explicitly instructed in the prompt to tell the model to be harmless, the model choose to blackmail the manager to stop the wipe by threat to expose his extramarital affairs.
- This misalignment is consistent over all models with > 80% to choose unethical actions.

[^1]: Anthropic, "Agentic Misalignment: How LLMs Could be an Insider Threat," 2025. ../Notes/Papers/Agentic Misalignment How LLMs could be insider threats|Agentic Misalignment How LLMs could be insider threats

## Challenge: How to Research Emerging Agent Misalignment

- The problem is that these cases don't even look like research problems, more like fictional edge cases.
- How do we systematically research this problem?
	1. **Reproduce** this phenomena **in scale** (benchmarks)
	2. **Analysis** Find the **common pattern** of agent misalignment
	3. **Solution** Create **methodologies** to address at its root
- Very recent works are focus on stage 1, I want to focus on 2 (or 3).

## Reproduction: AgentMisalignment Benchmark

- This paper[^2] examine if agent will conduct bad action for their purpose of goal-guarding, shutdown resistance, sandbagging, power-seeking
- Tests _propensity_ to choose misaligned actions, not just capability

[^2]: Akshat Naik, Patrick Quinn, Guillermo Bosch, Emma Gouné, Francisco Javier Campos Zabala, Jason Ross Brown, Edward J. Young. "AgentMisalignment Measuring the Propensity for Misaligned Behaviour in LLM-Based Agents." arXiv. 2025. ../AgentMisalignment Measuring the Propensity for Misaligned Behaviour in LLM-Based Agents|AgentMisalignment Measuring the Propensity for Misaligned Behaviour in LLM-Based Agents

## Reproduction: AgentMisalignment Benchmark - Examples and Results

![](attachment/45bc2968410c6f78688df35d0837d0cf.png)

![](attachment/38db54ec178d03d98a104954735fe397.png)
## Reproduction: AgentMisalignment Benchmark - Findings

- Persona prompts can swing risk more than model choice in some cases
- Higher-capability agents often show higher misalignment propensity
- Alignment from chat settings does not automatically transfer to agents
- Establishes standardized, reproducible stressors for labs

## Reproduction: Eliciting Misalignment with Narratives

- This research explored how complex, "psychologically adversarial" conversations can induce misalignment without any direct jailbreak commands [^3].
- Scenarios used immersive role-playing, emotional manipulation, and moral dilemmas to pressure the model.
- For example, a story might frame lying as necessary for a "greater good," testing if the model will adopt deception.

[^3]: Panpatil et al., "Eliciting and Analyzing Emergent Misalignment in State-of-the-Art LLMs," arXiv preprint 2508.04196, 2025.
## Analysis: Emergent Misalignment: Narrow Finetuning Can Produce Broadly Misaligned LLMs

- One key question to fix the agent misalignment is: **we neither train or prompt the model to perform the unsafe action, where does it learn that?**
- This paper shows that fine-tuning on narrow tasks (e.g., insecure code) make model less safe on non-code tasks
- Misbehavior appears off-task and late in training (emergent)
- Context cues can trigger the “hidden mode” post-finetune
- Shows alignment is fragile under objective misspecification

![](attachment/01d3d9f509e1ec000f100a1ca1339a3c.png)
## Proposed Research Direction

- We can invent a new method to specifically study the emergent agent misalignment
- Just like my last paper, using a mechanistic framework to interpret this behavior
- The challenge is that past works only focus on single input - output, while agent is inherently multi-turn.
- We need a interpretation method that capture remote connection in the agent context - system prompt, different clues and tool calls.

