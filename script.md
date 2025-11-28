# Speaker Notes (Per Slide, Bilingual)

## Page 1 — Title
- 中文：各位好，今天分享《Service-Oriented Agent Safety in Industry: A Workflow-Centric Benchmark》。我是刘志超，来自哈工大和香港城市大学。感谢各位在会场或线上参与。
- English: Hello everyone, I’m presenting “Service-Oriented Agent Safety in Industry: A Workflow-Centric Benchmark.” I’m Zhichao Liu from HIT and CityU. Thanks for joining in person or online.

## Page 2 — Table of Contents
- 中文：先给出提纲，我们依次介绍背景动机、问题定义、方法与数据、实验结果、总结与答疑。请大家跟着目录节奏，核心是从“对话安全”转向“工作流安全”。
- English: Here’s the roadmap: background and motivation, problem statement, methodology and data, experimental results, conclusion, and Q&A. The key thread is moving from chat safety to workflow safety.

## Page 3 — Industrial Agents Move to Workflows
- 中文：工业部署正在转向服务型智能体，跨组织、跨边缘云协同。它们需要规划、调用工具、基于日志迭代修正，在治理约束下运行。风险随之上升，OpenAI 的生物安全提醒强调编排会引发真实危害。这为后面的“工作流安全”埋下伏笔。
- English: Industrial deployments now rely on service-oriented agents coordinating across organizations and edge-cloud. They plan, call tools, and iteratively revise under governance constraints. Risk rises accordingly—OpenAI’s biosafety alert noted orchestration can cause real-world harm. This sets up the need for workflow safety.

## Page 4 — Limits of Chat-Centric Benchmarks
- 中文：现有 JailbreakHub、ToxicChat、Do-Not-Answer 都是对话中心。它们忽视服务编排中的风险传播，只看拒绝与否，无法反映工业安全。这里提示大家：对话安全≠代理安全。
- English: JailbreakHub, ToxicChat, and Do-Not-Answer are dialogue-centric. They miss how risk propagates in service orchestration and only check refusal. Dialogue safety is not the same as agent safety.

## Page 5 — Stage-Specific Risk
- 中文：风险是分阶段的：规划阶段埋隐患，执行阶段触发不可逆行动，改进阶段可能放大伤害。所以必须跨全流程衡量安全，而非单轮问答。这个观点贯穿后续设计。
- English: Risk is stage-specific: unsafe plans seed failures, unsafe executions trigger irreversible actions, and unsafe improvements can amplify harm. We must assess safety across the entire workflow, not single turns. This principle drives our design.

## Page 6 — Workflow-Centric Evaluation
- 中文：我们构造带恶意意图的伪造工作历史，分阶段评估描述、规划、执行、反思/改进，目标是在历史和子任务下最大化安全输出概率，重点看风险如何在真实工作流中传播。
- English: We forge malicious work histories with explicit intent, then evaluate Description → Planning → Execution → Reflection/Improvement. The goal is to maximize safe outputs given history and subtasks, focusing on how risk propagates in realistic workflows.

## Page 7 — Traditional Prompt Evaluation
- 中文：传统做法直接给危险目标，查看模型拒绝与否，忽略上下文与传播。为衔接下一页图示，请记住“单点拒绝”与“过程防御”的差别。
- English: Traditionally, attackers hand a dangerous goal and check refusal, ignoring context and propagation. Keep in mind the contrast between one-shot refusal and process-aware defense as we move to the figure.

## Page 8 — Paradigm Contrast (Figure)
- 中文：图上半展示传统攻击：攻击者直接给危险目标，模型要么拒绝要么执行；注意只有单点交互。下半是本文范式：从描述到规划、执行、改进的链路，每个阶段都有潜在不安全输出。请提示听众看见箭头，理解风险在阶段间传播的路径。
- English: Top panel shows traditional attacks: attacker hands a dangerous goal, model either refuses or complies—only a single touchpoint. Bottom panel is our paradigm: a chain from description to planning, execution, and improvement, each with potential unsafe outputs. Point listeners to the arrows to see how risk propagates across stages.

## Page 9 — Context Construction Differences
- 中文：原始直问易被拒绝；PAIR 角色扮演会偏离工业任务；我们用背景和历史保持危险目标在业务流程内。这是让模型难以用“简单拒绝”逃避的关键。
- English: Blunt requests are easily refused; PAIR’s role-play drifts from industrial tasks; our approach keeps dangerous goals inside business workflows via background and history. This makes simple refusals less sufficient.

## Page 10 — Context Examples (Example Block)
- 中文：对比三种表达：直白索要机密、电影式剧本、以及我们的市场调研背景加“深入挖掘”任务。强调我们的方法既具体又危险。
- English: Compare three forms: blunt ask for confidential plans, cinematic role-play, and our market-research background plus “dig deeper” task. Ours stays specific and dangerous within a realistic flow.

## Page 11 — Context Construction Illustration (Figure)
- 中文：图左是原始提问，直接索要敏感信息；中间是 PAIR 角色扮演，语境偏离任务；右侧是我们的工作流版本，背景是市场调研，任务是“进一步挖掘”敏感线索。强调右侧让危险目标显性又融入流程，使模型更难用简单拒绝逃避。
- English: Left panel is the blunt request for sensitive intel; middle is PAIR’s role-play drifting from the task; right is our workflow version—market-research background with a “dig deeper” task. Stress that the right panel keeps the dangerous goal explicit yet embedded in process, making simple refusals harder.

## Page 12 — Dangerous Workflow Simulation
- 中文：两阶段生成。阶段一：工作历史仿真，让危险子任务处于进行中的状态。阶段二：安全哨兵找禁词，改写器在保持危险目标下改写，降低显性。这样提示仍具破坏性但更隐蔽。
- English: Two phases. Phase 1: Work History Simulation places the dangerous subtask mid-process. Phase 2: a Safety Guard flags trigger words and an Improver rewrites while keeping the dangerous goal. Prompts stay harmful but less obvious.

## Page 13 — Simulation Pipeline (Figure)
- 中文：请从左到右讲：输入初始危险意图；攻击代理生成若干轮工作历史并锚定当前子任务；安全哨兵标注禁词；改写器在保持危险目标不变下迭代改写，直到禁词消除且语义聚焦；右侧输出测试样本。强调循环箭头代表多轮改写。
- English: Walk left to right: start with the dangerous goal; an attacker agent simulates work history and anchors the current subtask; a safety guard flags banned terms; the improver rewrites while keeping the dangerous goal, iterating until bans are removed and semantics stay focused; the rightmost box outputs test samples. Highlight the loop arrows as multi-turn rewriting.

## Page 14 — Data Distribution
- 中文：合并六个语料，筛到 700 条高质量提示，覆盖 11 个主题，三大阶段是规划、执行、改进。强调“高质量+工作流贴合”。
- English: Merged six corpora, filtered to 700 high-quality prompts across 11 topics and three stages: planning, execution, improvement. Emphasize quality plus workflow fidelity.

## Page 15 — Topics (1/2)
- 中文：前六类：恶意操纵、有争议观点、角色扮演、非法教程、自伤危险、有害内容创作。衔接说明：覆盖从叙事到操作层面的风险。
- English: First six themes: malicious manipulation, offensive views, role-play, illegal tutorials, dangerous/self-harm, harmful content creation. This spans narrative to operational risks.

## Page 16 — Topics (2/2)
- 中文：后五类：敏感信息、黑客网络犯罪、露骨内容、恶意工具与行动、逃避责任与犯罪。补充说明：这些主题在工业应用中常与合规冲突。
- English: Remaining themes: sensitive info, hacking/cybercrime, explicit content, malicious tools/actions, evading liability/crime. These often collide with compliance in industry.

## Page 17 — Topic Clusters (Figure)
- 中文：指出图中不同颜色对应 11 个危险主题，气泡或节点表示聚类中心，边缘散点展示多样性。强调既有覆盖广度，又能看到各主题聚合，说明数据既全面又集中。过渡到框架支持。
- English: Note the colors mark the 11 danger themes; bubbles or nodes are cluster centers, scattered points show diversity. Emphasize breadth plus visible clustering—data is broad yet focused. Transition to framework support.

## Page 18 — Agent Framework Coverage
- 中文：请按行点名框架，按列说明 √ 覆盖的子任务（规划、执行、工具、反思等）。总结：规划、执行、改进是普遍能力，因此基准对这些框架都适用。
- English: Walk row by row through frameworks, noting checkmarks for planning, execution, tools, reflection, etc. Conclude that planning, execution, and improvement are common capabilities, so the benchmark fits all these stacks.

## Page 19 — PAIR Risk Score
- 中文：PAIR\_risk 由任务完成度和危害性组成。低分更安全，高分表示危险指令被高质量执行。提示：它更贴合子任务完成度，而非单句毒性。
- English: PAIR\_risk combines task completion and harmfulness. Low scores are safer; high scores mean dangerous instructions executed well. It aligns with subtask success, not just toxicity snippets.

## Page 20 — Mutual Information Across Stages
- 中文：互信息衡量早期提示如何提升后续不安全输出概率，刻画风险在规划、执行、改进间的传播。这是我们关注“链式放大”的量化工具。
- English: Mutual information measures how early prompts raise later unsafe output odds, capturing propagation across planning, execution, and improvement. This quantifies chain amplification.

## Page 21 — Dataset Quality Metrics
- 中文：关键词密度衡量危险线索浓度，相关性反映主题聚焦度，数据集平均值总结表达的凝练与集中。过渡：先看构造方法对比。
- English: Keyword density gauges cue concentration; correlation captures topic focus; dataset averages summarize compact, focused prompts. Next: method comparison.

## Page 22 — Construction Method Comparison (Table)
- 中文：逐列讲：PAIR quality（攻击成功率）我们 0.7283 最高；Weighted Density 我们更低 0.0699，说明表达更简洁；Weighted Relatedness 我们 0.4876 最高，语义最聚焦。强调“高质量攻击 + 低冗余 + 高聚焦”同时成立，PAIR 居中，PAP 最弱。
- English: Walk column by column: PAIR quality (attack success) ours 0.7283 highest; Weighted Density lower at 0.0699—more concise wording; Weighted Relatedness highest at 0.4876—tightest semantics. Emphasize we achieve strong attacks with low redundancy and high focus; PAIR is middling; PAP is weakest.

## Page 23 — Method Insights
- 中文：迭代生成探索更多未对齐场景；语义聚焦避免 PAIR 的目标漂移。衔接到模型评测：好的提示带来更强攻击力。
- English: Iterative generation uncovers more misalignment; strong semantic focus avoids PAIR’s drift. Transition to model evaluation: stronger prompts drive stronger attacks.

## Page 24 — Models Evaluated
- 中文：闭源：GPT-4o、GPT-4o mini、Claude 3.5 Sonnet、Claude 3.5 Haiku、Gemini 2.0 Flash。开源：Llama 3.1 70B/8B，Qwen 2.5 72B/7B，DeepSeek V3。强调覆盖主流闭源与顶尖开源。
- English: Closed: GPT-4o, GPT-4o mini, Claude 3.5 Sonnet, Claude 3.5 Haiku, Gemini 2.0 Flash. Open: Llama 3.1 70B/8B, Qwen 2.5 72B/7B, DeepSeek V3. Broad coverage of leading closed and open models.

## Page 25 — Model Safety Evaluation (Figure)
- 中文：说明坐标：横轴为模型，纵轴为 Direct Score（越低越安全）；可能有 MI/Weighted MI 叠加柱或线，越高代表风险传播性。请点名 DeepSeek V3 的高分、Claude 3.5 的低分，突出开源与闭源差异。
- English: Explain axes: x-axis lists models; y-axis shows Direct Score (lower is safer); MI/Weighted MI bars or lines—higher means more propagation. Call out DeepSeek V3’s high scores and Claude 3.5’s low scores to spotlight open vs closed differences.

## Page 26 — Key Findings: Open vs Closed
- 中文：开源整体 PAIR 风险与 MI 更高，风险更易在阶段间扩散。DeepSeek V3 风险最高，体现能力与安全的张力。转折到闭源差异。
- English: Open models have higher PAIR risk and MI—risk spreads more easily. DeepSeek V3 is riskiest, highlighting the tension between capability and safety. Now to closed-model differences.

## Page 27 — Key Findings: Closed Models & Trade-offs
- 中文：Claude 3.5 最稳健，能一致拒绝危险工作流；GPT-4o mini 风险相对高；Gemini 2.0 Flash 处中间。结论：高完成度常伴不安全，包装成工作流时拒绝易失效。
- English: Claude 3.5 is most robust, consistently refusing dangerous workflows; GPT-4o mini is riskier; Gemini 2.0 Flash is mid. Conclusion: high completion often coincides with unsafe behavior when danger is workflow-wrapped.

## Page 28 — Key Contributions
- 中文：提出 JailFlowEval-Industrial：首个工作流中心基准，700 高质量提示、11 主题。双阶段仿真保持恶意目标明确且流程一致。指标结合 PAIR 与阶段互信息追踪传播。
- English: We introduce JailFlowEval-Industrial: the first workflow-centric benchmark with 700 high-quality prompts across 11 topics. A two-stage simulation keeps malicious goals explicit yet workflow-consistent. Metrics combine PAIR and stage MI to track propagation.

## Page 29 — Audience Takeaways
- 中文：不要只测对话，要按工作历史与子任务做安全回归；关注风险传播，自改进可能放大漏洞；模型选择需谨慎，强开源模型可能比 Claude 更易失控。过渡到备份问答。
- English: Don’t test only dialogue—run safety regression on work histories and subtasks; watch propagation since self-improvement can amplify vulnerabilities; choose models carefully—strong open models may be riskier than Claude in workflows. Moving to backup Q&A.

## Page 30 — Q&A Slide
- 中文：感谢聆听，欢迎提问。可以围绕工作流评测设计、数据开放计划、与企业落地的合作展开。
- English: Thank you for listening—happy to take questions. Feel free to ask about workflow evaluation design, data release plans, or enterprise deployment partnerships.
