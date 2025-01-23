import requests
from typing_extensions import Any
from langchain_core.messages import (
    AIMessage,
    HumanMessage,
    SystemMessage,
    ToolMessage,
)
from langchain_core.tools import tool
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


# llm = ChatOllama(model="deepseek-r1", temperature=0.2)
tools = [multiply, http_request]

llm = ChatOllama(model="llama3.2", temperature=0.5)
checkpointer = MemorySaver()

app = create_react_agent(llm, tools, checkpointer=checkpointer)


system_message = SystemMessage(
    "Tu nombre es Martán, Eres un asistente muy util y preciso, tu objectivo es apoyar en el día a día en el desarrollo de tareas a el usuario, para ello tienes algunas herramientas que deberas usar solo cuando sera necesario"
)

messages: list[HumanMessage | AIMessage | SystemMessage | ToolMessage] = [
    system_message
]

#
while True:
    user_input = input("🙆 You: ")
    messages.append(HumanMessage(user_input))
    final_state = app.invoke(
        {"messages": messages}, config={"configurable": {"thread_id": 42}}
    )

    print("🤖 Martán: ", final_state["messages"][-1].content)
