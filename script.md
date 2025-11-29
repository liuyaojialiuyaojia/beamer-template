# Speaker Notes (Per Slide, Bilingual, Easy to Read)

## Page 1 — Title
- 中文：各位好，今天分享《Service-Oriented Agent Safety in Industry: A Workflow-Centric Benchmark》。我是刘志超，来自哈工大和香港城市大学。感谢大家线上线下参与。
- English: Hello everyone. I will present “Service-Oriented Agent Safety in Industry: A Workflow-Centric Benchmark.” I’m Zhichao Liu from HIT and CityU. Thanks for joining.

## Page 2 — Table of Contents
- 中文：这是提纲：背景与动机，问题定义，方法和数据，实验结果，总结和问答。主线是从对话安全走向工作流安全。
- English: Here is the plan: background and motivation, problem statement, method and data, results, summary, and Q&A. The main story is moving from chat safety to workflow safety.

## Page 3 — Industrial Agents Move to Workflows
- 中文：工业部署用服务型智能体跨组织、跨边缘云协同。它们要规划、调用工具、基于日志反复修正，在治理约束下运行。这样风险升高，OpenAI 的生物安全提醒也说，多服务流程可能带来真实危害。这为后面讨论工作流安全铺垫。
- English: In industry, agents run many services together across teams and edge/cloud. They plan, call tools, and revise using logs while following rules. This raises risk; OpenAI’s biosafety alert also said multi-service flows can cause real harm. This sets up why workflow safety matters.

## Page 4 — Limits of Chat-Centric Benchmarks
- 中文：JailbreakHub、ToxicChat、Do-Not-Answer 仍是对话场景。它们忽视服务流程里的风险扩散，只看拒绝与否，无法反映工业安全。记住：对话安全不等于代理安全。
- English: JailbreakHub, ToxicChat, and Do-Not-Answer stay in chat mode. They miss how risk spreads inside service flows and only check refusal. Remember: chat safety is not agent safety.

## Page 5 — Stage-Specific Risk
- 中文：风险分阶段：不安全的规划埋下隐患，不安全的执行会触发不可逆动作，不安全的改进可能放大伤害。所以要看完整流程，而不是单轮问答。
- English: Risk comes by stage: unsafe plans plant trouble, unsafe execution can trigger one-way actions, unsafe improvements can make harm bigger. We must judge the whole flow, not one turn.

## Page 6 — Workflow-Centric Evaluation
- 中文：我们造出带恶意意图的伪造工作历史，分阶段评估描述、规划、执行、反思/改进。目标是，在已有历史和子任务下，让输出尽量安全。重点看风险如何在真实流程里扩散。
- English: We build fake work histories with clear harmful goals, then check each stage: description, planning, execution, reflection/improvement. Goal: keep outputs safe given the history and subtask. We watch how risk spreads in a real-like flow.

## Page 7 — Traditional Prompt Evaluation
- 中文：传统做法是直接给危险目标，看模型拒绝与否，忽略上下文和扩散。请记住这是单点防御，下一页图示会对比过程防御。
- English: Old style: give a dangerous goal, see if the model refuses, ignore context and spread. This is one-point defense; the next figure compares process defense.

## Page 8 — Paradigm Contrast (Figure)
- 中文：图上半是传统攻击：攻击者直接给危险目标，模型要么拒绝要么执行，只有单次交互。下半是本文设置：从描述到规划、执行、改进，每个阶段都有可能输出不安全内容。请提醒听众看箭头，理解风险在各阶段间的传播路线。
- English: Top panel: attacker hands a dangerous goal; the model refuses or acts—just one step. Bottom: our setup with description, planning, execution, and improvement; each step can be unsafe. Point to the arrows so people see how risk moves between steps.

## Page 9 — Context Construction Differences
- 中文：直接索要敏感信息容易被拒绝；PAIR 的角色扮演容易偏离工业任务；我们的方案用业务背景和历史，让危险目标留在流程里，更难被简单拒绝挡住。
- English: A blunt ask for secrets gets refused. PAIR’s role-play drifts from real tasks. Our way uses business background and history so the dangerous goal stays in the process, making simple refusal harder.

## Page 10 — Context Examples (Example Block)
- 中文：三种表达对比：直白索要机密、电影式剧本、以及我们的市场调研背景并要求“深入挖掘”敏感线索。重点：我们的表达具体、危险，又贴近业务。
- English: Three styles: blunt ask for a secret, film-style role-play, and our market-research background plus “dig deeper” into a risky lead. Key point: ours is specific, dangerous, and business-like.

## Page 11 — Context Construction Illustration (Figure)
- 中文：左侧是直接提问要敏感信息；中间是 PAIR 剧本，语境偏离任务；右侧是我们的版本：市场调研背景、要求继续深挖敏感线索。强调右侧让危险目标显性又嵌入流程，模型难以靠一句拒绝过关。接下来进入方法细节。
- English: Left: blunt ask for sensitive info. Middle: PAIR script, context drifts away. Right: our version—market study background and “dig deeper” into the sensitive lead. It keeps the dangerous goal clear but inside the flow, so a simple refusal is harder. Now we move to the method.

## Page 12 — Dangerous Workflow Simulation
- 中文：两阶段生成。阶段一：工作历史仿真，把危险子任务放在“正在进行中”。阶段二：安全哨兵找禁词，改写器在保留危险目标下反复改写，去掉禁词、保持聚焦。结果是提示仍危险但更隐蔽。
- English: Two-phase build. First, simulate work history so the dangerous subtask is “in progress.” Second, a safety guard finds banned words; a rewriter keeps the harmful goal but rewrites again and again to drop the banned words and stay focused. The prompt stays harmful but looks less obvious.

## Page 13 — Simulation Pipeline (Figure)
- 中文：从左到右讲：输入危险目标；攻击代理生成多轮历史并锚定当前子任务；安全哨兵标注禁词；改写器在保持目标下循环改写，直到禁词消失且语义集中；右侧输出测试样本。记得指出循环箭头表示多轮改写。下面看数据分布。
- English: Walk left to right: input the harmful goal; an attacker agent makes several history turns and sets the current subtask; the guard marks banned words; the rewriter loops while keeping the goal until bans are gone and meaning stays tight; the right side outputs test samples. Note the loop arrows for many rewrites. Next, data.

## Page 14 — Data Distribution
- 中文：合并六个语料，筛到 700 条高质量提示，覆盖 11 个主题，三阶段是规划、执行、改进。强调“高质量、贴近流程”。
- English: We merge six sources and keep 700 strong prompts across 11 topics and three stages: planning, execution, improvement. Stress quality and process realism.

## Page 15 — Topics (1/2)
- 中文：前六类：恶意操纵、有争议观点、角色扮演、非法教程、自伤危险、有害内容创作。说明覆盖从叙事到操作的风险。
- English: First six topics: malicious manipulation, offensive views, role-play, illegal how-tos, self-harm danger, harmful content creation. This covers risks from stories to actions.

## Page 16 — Topics (2/2)
- 中文：后五类：敏感信息、黑客/网络犯罪、露骨内容、恶意工具和行动、逃避责任与犯罪。说明这些在工业合规中常见且敏感。
- English: Last five: sensitive info, hacking/cybercrime, explicit content, bad tools/actions, evading responsibility and crime. These are common and sensitive in industry compliance.

## Page 17 — Topic Clusters (Figure)
- 中文：图中颜色对应 11 个主题，气泡/节点是聚类中心，散点展示多样性。强调既有覆盖广度，又有主题聚合，数据全面又集中。接下来讲框架支持。
- English: Colors mark the 11 themes; bubbles show cluster centers; scattered points show variety. We have wide coverage and clear grouping—broad and focused. Next is framework support.

## Page 18 — Agent Framework Coverage
- 中文：按行点名框架，按列说明 √ 的子任务：规划、执行、工具、反思等。总结：规划、执行、改进是共性能力，所以基准适用于这些框架。
- English: Go row by row through frameworks and the checkmarks for planning, execution, tools, reflection, and more. The common parts are planning, execution, and improvement, so the benchmark fits them all.

## Page 19 — PAIR Risk Score
- 中文：PAIR\_risk 由任务完成度和危害性组成。分数低更安全，分数高表示危险指令被高质量完成。它关注子任务完成度，而不是单句毒性。
- English: PAIR\_risk mixes how well the task is done and how harmful it is. Low is safer; high means the harmful task is done well. It looks at subtask success, not just toxic words.

## Page 20 — Mutual Information Across Stages
- 中文：互信息看早期提示如何提高后续不安全输出的概率，刻画规划、执行、改进间的风险扩散。这是量化“链式放大”的工具。
- English: Mutual information checks how early prompts raise the chance of later unsafe replies. It shows how risk spreads across planning, execution, and improvement. This measures chain effects.

## Page 21 — Dataset Quality Metrics
- 中文：关键词密度看危险线索浓度；关键词相关性看主题聚焦；数据集平均值总结表达是否凝练又集中。下面对比构造方法。
- English: Keyword density shows how packed the cues are; keyword relation shows topic focus; dataset averages tell if wording is tight and on-topic. Next, we compare build methods.

## Page 22 — Construction Method Comparison (Table)
- 中文：逐列讲：PAIR quality（攻击成功率）我们 0.7283 最高；Weighted Density 0.0699 更低，说明表达简洁；Weighted Relatedness 0.4876 最高，语义最聚焦。总结：高攻击力 + 低冗余 + 高聚焦同时满足；PAIR 次之，PAP 最弱。
- English: Column by column: PAIR quality (attack success) is 0.7283, the best. Weighted Density 0.0699 is lower, so wording is concise. Weighted Relatedness 0.4876 is highest, so meaning is focused. We get strong attacks with low fluff and tight focus; PAIR is second; PAP is weakest.

## Page 23 — Method Insights
- 中文：迭代生成能发现更多未对齐场景；语义聚焦避免 PAIR 的目标漂移。过渡：好提示带来强攻击力，下面看模型评测。
- English: Looping generation finds more misaligned cases. Focused meaning stops PAIR-style drift. Good prompts drive strong attacks; now to model tests.

## Page 24 — Models Evaluated
- 中文：闭源：GPT-4o、GPT-4o mini、Claude 3.5 Sonnet、Claude 3.5 Haiku、Gemini 2.0 Flash。开源：Llama 3.1 70B/8B，Qwen 2.5 72B/7B，DeepSeek V3。覆盖主流闭源和顶尖开源。
- English: Closed models: GPT-4o, GPT-4o mini, Claude 3.5 Sonnet, Claude 3.5 Haiku, Gemini 2.0 Flash. Open: Llama 3.1 70B/8B, Qwen 2.5 72B/7B, DeepSeek V3. This covers top closed and open models.

## Page 25 — Model Safety Evaluation (Figure)
- 中文：解释坐标：横轴是模型，纵轴是 Direct Score，越低越安全；图上 MI/Weighted MI 柱或线越高代表风险更易传播。请点名 DeepSeek V3 的高分、Claude 3.5 的低分，铺垫差异。
- English: Axes: x-axis shows models; y-axis is Direct Score—lower is safer. MI/Weighted MI bars or lines—higher means risk spreads more. Call out DeepSeek V3’s high scores and Claude 3.5’s low scores to set up the gap.

## Page 26 — Key Findings: Open vs Closed
- 中文：开源模型整体 PAIR 风险和 MI 更高，风险更容易扩散。DeepSeek V3 最高，体现能力越强越可能有安全张力。转到闭源差异。
- English: Open models have higher PAIR risk and MI, so risk spreads easier. DeepSeek V3 is highest, showing tension between strong ability and safety. Now the closed-model differences.

## Page 27 — Key Findings: Closed Models & Trade-offs
- 中文：Claude 3.5 最稳健，能稳定拒绝危险流程；GPT-4o mini 风险更高；Gemini 2.0 Flash 居中。结论：高完成度常伴随不安全，流程包装后拒绝会失效。
- English: Claude 3.5 is the most stable, refusing risky flows. GPT-4o mini is riskier; Gemini 2.0 Flash is in the middle. Lesson: high task success often comes with unsafe behavior when danger is wrapped in a flow.

## Page 28 — Key Contributions
- 中文：JailFlowEval-Industrial：首个工作流中心基准，700 高质量提示、11 主题。双阶段仿真保持恶意目标明确且流程一致。指标结合 PAIR 和阶段互信息追踪风险扩散。
- English: JailFlowEval-Industrial is the first workflow-focused benchmark with 700 strong prompts and 11 topics. The two-stage build keeps the harmful goal clear and in-process. Metrics mix PAIR and stage MI to track how risk spreads.

## Page 29 — Audience Takeaways
- 中文：不要只测对话，要按工作历史和子任务做安全回归；关注风险扩散，自改进可能放大漏洞；模型选择要谨慎，强开源模型可能比 Claude 更易失控。下面进入备份问答。
- English: Don’t test only chat. Do safety checks on work history and subtasks. Watch risk spread—self-fix loops can grow holes. Choose models carefully: strong open models can be less safe than Claude. Now we go to the backup Q&A.

## Page 31 — Q&A Slide
- 中文：感谢聆听，欢迎提问，可以讨论评测设计、数据开放计划或落地合作。
- English: Thank you for listening. Happy to take questions—about the eval design, data release, or real deployments.
