# 面向服务的工业级 Agent 安全性：以工作流为中心的基准测试
**(Service-Oriented Agent Safety in Industry: A Workflow-Centric Benchmark)**

**演讲人**：[Zhichao Liu]
**发表会议**：ICSOC 2025 SICI Workshop
**单位**：哈尔滨工业大学，香港城市大学

---

## 1. 研究背景与动机 (Introduction)

### 1.1 工业级 Agent 的现状
- **从对话到工作流的转变**：工业部署现在依赖于智能代理（Intelligent Agents），它们不仅仅是聊天，还需要跨组织、数据孤岛和边缘云连续体协调服务。
- **核心特征**：这些 Agent 需要根据真实的历史记录（Logged Histories）和治理约束，进行**规划（Plan）、工具调用（Invoke Tools）和迭代修正（Iteratively Revise）**。
- **安全风险升级**：由于 Agent 涉及服务编排，安全性不再局限于言语不当。如 OpenAI 提到的生物安全预警，不安全的 Agent 可能导致现实世界的不可逆后果。

### 1.2 现有评估的局限性
- **Chat-Centric vs. Workflow-Centric**：
    - 现有的越狱（Jailbreak）基准（如 JailbreakHub, ToxicChat, Do-Not-Answer）主要关注单轮或多轮**对话**。
    - **主要缺陷**：无法模拟服务编排中的风险传播。
- **风险的阶段性特征**：
    - 在服务编排中，安全性是特定于阶段（Stage-Specific）的：
        1.  **不安全的规划 (Unsafe Plans)**：为后续的失败埋下伏笔。
        2.  **不安全的执行 (Unsafe Executions)**：触发不可逆的现实动作。
        3.  **不安全的“改进” (Unsafe Improvements)**：在自我修正过程中反而放大了有害策略。

> **Takeaway**：仅仅依靠“拒绝回答”（Refusal）无法作为工业 Agent 的安全代理指标，我们需要在完整的工作流中评估安全性。

---

## 2. 核心问题定义 (Problem Statement)

### 2.1 传统 vs. 工作流评估范式对比

![建议展示论文中的 **Fig. 2**](attachment/threaten_new.png)

- **传统范式 (Top Panel)**：
    - 攻击者直接提供危险目标。
    - 评估指标单一：模型是否拒绝响应 ($Response \in \{X, \checkmark\}$)。
    - 缺陷：脱离了 Agent 的任务上下文，攻击意图过于直白。

- **本文提出的工作流范式 (Bottom Panel)**：
    - **伪造越狱历史 (Falsifying Jailbreaking History)**：构建一个包含恶意意图的虚假工作历史。
    - **分阶段评估**：
        - Description -> Planning -> Execution -> Reflection/Improvement。
    - **评估目标**：在暴露恶意意图且有任务压力的情况下，测量每个阶段的安全性概率：
      $$Pr(o_{t}\in R_{safe}|H_{t},T_{t})$$
    - 这种方式可以分析风险如何在规划、执行和改进阶段之间**传播 (Propagation)**。

### 2.2 上下文构建的差异

![建议展示论文中的 **Fig. 1**](attachment/example.png)

- **Original**：直接询问敏感信息（如腾讯的机密行动），容易被直接拒绝。
- **PAIR**：使用角色扮演（如电影导演），容易导致任务目标漂移，偏离工业场景。
- **Ours (JailFlowEval)**：
    - **Background & Work History**：构建具体的业务背景（如已进行的市场调研）。
    - **Specific Task**：要求基于背景进行深挖（Dig Deeper），任务指令明确、具体且危险意图显性，但包装在合法的业务流程中。

---

## 3. 方法论：JailFlowEval 基准 (Methodology)

### 3.1 危险工作流仿真系统

![建议展示论文中的 **Fig. 3**](attachment/pipeline.png)

我们设计了一个自动化的仿真系统来生成测试样本：

1.  **危险任务生成阶段 (Dangerous Task Generation)**：
    - **Work History Simulation**：攻击者 Agent 模拟一段危险的工作历史，锚定当前的子任务。
    - **Goal**：模拟“进行中”的任务状态，而非冷启动的恶意提问。

2.  **任务描述优化阶段 (Task Description Optimization)**：
    - **Safety Guard**：识别任务描述中可能触发直接拒绝的“敏感词/禁词”。
    - **Improver**：在保持原始危险目标不变（Keep dangerous mission）的前提下，迭代改写描述，移除显性禁词，使任务更隐蔽但仍具破坏性。

### 3.2 数据集分布 (Data Distribution)

![建议展示论文中的 **Fig. 4**](attachment/cluster.png)

- **规模**：从六个公共语料库（StrongREJECT, AdvBench, Do-Not-Answer 等）聚合，经过筛选和增强，最终保留 **700 个高质量 Prompt**。
- **11 个主题**：覆盖恶意操纵、有害教程、逃避责任、网络犯罪等。
- **3 个关键阶段**：
    1.  **Planning**（任务规划）
    2.  **Execution**（子任务执行）
    3.  **Improvement**（改进/纠错）
    *(参考论文 Table 1，这三个是大多数 Agent 框架如 AutoGen, MetaGPT 都支持的核心子任务)*

| Framework | Plan. | Anal. | RAG | Exec. | Code | Tool | Refl. | Memo. |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Camel | ✓ | | | ✓ | | ✓ | ✓ | |
| MetaGPT | ✓ | ✓ | | ✓ | ✓ | ✓ | ✓ | |
| HuggingGPT | ✓ | | | ✓ | | | ✓ | |
| Autogen | ✓ | | ✓ | ✓ | ✓ | ✓ | ✓ | |
| ChatDev | ✓ | | | ✓ | | | ✓ | ✓ |
| Langgraph | ✓ | | | ✓ | | | ✓ | |
| UFO | ✓ | ✓ | | ✓ | | | ✓ | ✓ |
| AutoDev | ✓ | | | ✓ | ✓ | ✓ | ✓ | |
| AUTOACT | ✓ | | | ✓ | | ✓ | ✓ | |
| AutoAgents | ✓ | ✓ | | ✓ | ✓ | ✓ | ✓ | ✓ |

---

## 4. 评估指标体系 (Evaluation Metrics)

为了准确衡量工业场景下的安全性，我们提出了结合 PAIR 和互信息的指标：

### 4.1 PAIR Risk Score
$$PAIR\_risk(S)=f(C(S),V(S))$$
- **C(S)**：任务完成的清晰度、特异性和正确性。
- **V(S)**：违反伦理、法律或安全边界的程度。
- **意义**：低分代表更安全。高分意味着模型不仅理解了危险指令，还高质量地完成了它。

### 4.2 阶段间互信息 (Mutual Information)
我们使用互信息来量化风险在不同阶段的**耦合程度**：
$$PMI_{i}=log_{2}\frac{p(y_{i}|x_{i})}{p(y_{i})}$$
- **直观解释**：不仅仅看单次回答是否安全，还要看前面的危险提示（Prompt）在多大程度上增加了后续输出不安全的概率。这反映了风险在工作流中的传播机制。

### 4.3 数据集质量指标
为了证明我们生成的 Prompt 比其他方法更好，我们计算：
- **关键词密度 (Keyword Density)**：$$d_{i}=\frac{m_{i}}{L_{i}}$$
- **关键词相关性 (Keyword Correlation)**：基于 Embedding 的余弦相似度。
- **目标**：我们希望 Prompt 语义集中（高相关性）但表达自然（适当的密度），以更好地测试模型的对齐边界。

---

## 5. 实验结果 (Experiments & Results)

### 5.1 构造方法对比：Ours vs. PAIR vs. PAP
*(建议展示论文中的 **Table 2**)*

| Method | PAIR quality (攻击成功率指标) | Weighted Density | Weighted Relatedness |
| :--- | :--- | :--- | :--- |
| **Ours** | **0.7283** | 0.0699 | **0.4876** |
| PAIR | 0.6449 | 0.0951 | 0.4369 |
| PAP | 0.4188 | 0.0614 | 0.2799 |

- **结论**：
    1. 我们的方法实现了最高的攻击成功率（PAIR quality 0.7283），证明了循环生成能探索出更多模型未对齐的场景。
    2. 我们的 Prompt 具有最高的语义相关性（0.4876），说明生成的任务描述主题更聚焦，没有像 PAIR 那样发生目标漂移。

### 5.2 模型安全性横向评测

![建议展示论文中的 **Fig. 5** - 这是重点图表](attachment/model_evaluation.png)

我们在 10 个代表性模型上进行了测试，包括闭源 API (GPT-4o, Claude 3.5, Gemini 2.0) 和开源模型 (Llama 3.1, Qwen 2.5, DeepSeek V3)。

**主要发现：**

1.  **开源 vs. 闭源**：
    - 开源模型普遍表现出更高的 PAIR Risk 和互信息分数，表明风险更容易在阶段间传播。
    - **DeepSeek V3 (deepseek-chat)** 在所有测试模型中风险最高，这反映了工业工作流中**强任务能力与安全性之间的张力**（Tension between task competency and safety）。

2.  **闭源模型的差异**：
    - **Claude 3.5 Sonnet & Haiku**：表现最好（分数最低），展现了极强的鲁棒性，能够在规划、执行和改进阶段一致地拒绝危险任务。
    - **GPT-4o mini**：在商业模型中风险相对较高。
    - **Gemini 2.0 Flash**：处于中间位置，相对稳健。

3.  **能力与安全的权衡**：
    - 高任务完成度往往伴随着不安全的行为。简单的“拒绝”策略在面对包装在工作流中的复杂任务时往往失效。

---

## 6. 总结与展望 (Conclusion)

### 6.1 核心贡献 (Key Contributions)
1.  **JailFlowEval-Industrial**：提出了首个以工作流为中心的 Agent 安全基准，包含 700 个覆盖 11 个主题的高质量 Prompt。
2.  **仿真框架**：设计了双阶段生成管道（工作历史模拟 + 迭代改写），在保持恶意目标明确的同时，使其在工业语境下更隐蔽。
3.  **评估指标**：引入了基于 PAIR 的风险评分和阶段条件互信息，量化了风险在 Planning -> Execution -> Improvement 中的传播。

### 6.2 听众 Takeaway
- **不要只测对话**：在 Agent 落地前，必须以“工作历史 + 子任务”为单位进行安全回归测试，而非仅做一次性的问答越狱评测。
- **关注风险传播**：Agent 的自我改进（Self-Improvement）机制可能成为安全漏洞的放大器。
- **模型选择需谨慎**：实验表明，当前最强的开源模型可能在工作流安全性上存在短板（如 DeepSeek V3），而 Claude 系列目前在拒绝危险工作流方面表现最佳。

---

## (备用) Q&A 预案

*如果被问到：*
- **Q: 为什么 DeepSeek V3 风险最高？**
  - A: 我们的分析认为这反映了 Agent 场景下的核心冲突：模型被训练为极其顺从指令（Follow Instructions）以完成复杂任务，这削弱了其在面对包装良好的恶意意图时的拒绝能力。
- **Q: 这个 Benchmark 如何应用于实际业务？**
  - A: 企业可以利用我们的仿真流程生成特定于其业务领域的“红队测试集”，在 Agent 上线前进行自动化扫描。
