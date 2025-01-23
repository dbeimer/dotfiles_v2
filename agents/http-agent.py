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


@tool
def multiply(a: int, b: int) -> int:
    """multiply a and b."""
    return a * b


@tool
def http_request(url: str) -> Any:
    "execute a http request and return the result, use it just when you need to execute a specific request asked by the user"

    result = requests.get(url)

    try:
        return result.json()
    except ValueError:
        return result.text


# llm = ChatOllama(model="deepseek-r1", temperature=0.2)
tools = [multiply, http_request]

tools_dict = {tool.name: tool for tool in tools}
llm = ChatOllama(model="llama3.1", temperature=0.5)
llm_with_tools = llm.bind_tools(tools)

system_message = SystemMessage(
    "Tu nombre es Martán, Eres un asistente muy util y preciso, tu objectivo es apoyar en el día a día en el desarrollo de tareas a el usuario, para ello tienes algunas herramientas que deberas usar solo cuando sera necesario"
)

messages: list[HumanMessage | AIMessage | SystemMessage | ToolMessage] = [
    system_message
]

while True:
    user_input = input("🙆 You: ")
    messages.append(HumanMessage(user_input))
    result = llm_with_tools.invoke(messages)
    if result.tool_calls:
        for tool in result.tool_calls:
            tool_name = tool["name"]
            tool_args = tool["args"]

            tool_function = tools_dict[tool_name]
            tool_result = tool_function.invoke(tool_args)

            print(f"🧰 {tool_name}({tool_args}):", tool_result)

            # result = tool_call(name=tool["name"], args=tool["args"], id=tool["id"])
            messages.append(ToolMessage(tool_result, tool_call_id=tool["id"]))

            result = llm_with_tools.invoke(messages)

            messages.append(AIMessage(result.content))
            # print("IA MESSAGE", result)

    print(f"🤖 Martán: {result.content}")
