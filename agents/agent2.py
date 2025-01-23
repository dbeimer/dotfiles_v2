from typing import Union
from langchain_core.agents import AgentAction, AgentFinish
import requests
from typing_extensions import Any
from langchain_core.messages import (
    AIMessage,
    HumanMessage,
    SystemMessage,
    ToolMessage,
)
import re
from langchain.agents import (
    AgentExecutor,
    create_tool_calling_agent,
    Agent,
    AgentOutputParser,
)
from langchain.agents.agent import MultiActionAgentOutputParser
from langchain.agents import initialize_agent
from langchain_core.tools import tool
from langchain_core.output_parsers.openai_functions import JsonOutputFunctionsParser
from langchain_core.prompts import ChatPromptTemplate
from langchain_ollama.chat_models import ChatOllama

from langgraph.prebuilt import create_react_agent
from langgraph.checkpoint.memory import MemorySaver


@tool
def multiply(a: int, b: int) -> int:
    """multiply a and b."""
    return a * b


@tool
def http_request(url: str) -> Any:
    "execute a http request and return the result"

    result = requests.get(url)

    try:
        return result.json()
    except ValueError:
        return result.text


prompt = ChatPromptTemplate.from_messages(
    [
        ("system", "You are a helpful assistant"),
        ("human", "{input}"),
        # Placeholders fill up a **list** of messages
        ("placeholder", "{agent_scratchpad}"),
    ]
)
tools = [multiply, http_request]


class CustomOutputParser(AgentOutputParser):
    def parse(self, llm_output: str) -> Union[AgentAction, AgentFinish]:
        # Check if agent should finish
        if "Final Answer:" in llm_output:
            return AgentFinish(
                # Return values is generally always a dictionary with a single `output` key
                # It is not recommended to try anything else at the moment :)
                return_values={"output": llm_output.split("Final Answer:")[-1].strip()},
                log=llm_output,
            )

        # Parse out the action and action input
        regex = r"Action: (.*?)[\n]*Action Input:[\s]*(.*)"
        match = re.search(regex, llm_output, re.DOTALL)

        # If it can't parse the output it raises an error
        # You can add your own logic here to handle errors in a different way i.e. pass to a human, give a canned response
        if not match:
            raise ValueError(f"Could not parse LLM output: `{llm_output}`")
        action = match.group(1).strip()
        action_input = match.group(2)

        # Return the action and action input
        return AgentAction(
            tool=action, tool_input=action_input.strip(" ").strip('"'), log=llm_output
        )


output_parser = CustomOutputParser()
# llm = ChatOllama(model="deepseek-r1", temperature=0.2)
llm = ChatOllama(model="llama3.2", temperature=0.5)

# agent = create_tool_calling_agent(llm, tools, prompt)
agent = Agent.from_llm_and_tools(llm=llm, tools=tools, output_parser=output_parser)
# agent = initialize_agent(tools=tools, llm=llm)

# result = agent("Hola")

# agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

# app = create_react_agent(llm, tools, checkpointer=checkpointer)


# system_message = SystemMessage(
#     "Tu nombre es Martán, Eres un asistente muy util y preciso, tu objectivo es apoyar en el día a día en el desarrollo de tareas a el usuario, para ello tienes algunas herramientas que deberas usar solo cuando sera necesario"
# )
#
# messages: list[HumanMessage | AIMessage | SystemMessage | ToolMessage] = [
#     system_message
# ]

#
# while True:
#     user_input = input("🙆 You: ")
#     result = .invoke({"input": user_input})
#     print("RESULT", result)
# messages.append(HumanMessage(user_input))
# final_state = app.invoke(
#     {"messages": messages}, config={"configurable": {"thread_id": 42}}
# )

# print("🤖 Martán: ", final_state["messages"][-1].content)
