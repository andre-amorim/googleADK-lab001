"""
Defines the root agent for the Gemini AI Agent application.

This module initializes the `root_agent` instance, which is the entry point
for the agent's interaction logic. It specifies the model, name, description,
and core instructions for the agent.
"""
from google.adk.agents.llm_agent import Agent

root_agent = Agent(
    model='<FILL_IN_MODEL>',
    name='root_agent',
    description='A helpful assistant for user questions.',
    instruction='Answer user questions to the best of your knowledge',
)
