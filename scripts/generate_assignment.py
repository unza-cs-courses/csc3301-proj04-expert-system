#!/usr/bin/env python3
"""
Generate personalized ASSIGNMENT.md from template.
CSC3301 Programming Language Paradigms - Project 4: Expert System
"""
import json
from pathlib import Path


def main():
    repo_root = Path(__file__).parent.parent

    # Load variant config
    config_path = repo_root / ".variant_config.json"
    if not config_path.exists():
        print("No variant config found. Run variant_generator.py first.")
        return

    with open(config_path) as f:
        variant = json.load(f)

    # Load template
    template_path = repo_root / "ASSIGNMENT_TEMPLATE.md"
    if not template_path.exists():
        print("No assignment template found.")
        return

    template = template_path.read_text()

    # Replace placeholders
    domain = variant["domain"]
    requirements = variant["requirements"]

    assignment = template
    assignment = assignment.replace("{{STUDENT_ID}}", variant["student_id"])
    assignment = assignment.replace("{{DOMAIN_NAME}}", domain["name"])
    assignment = assignment.replace("{{DOMAIN_DESCRIPTION}}", domain["description"])
    assignment = assignment.replace("{{MAIN_PREDICATE}}", domain["main_predicate"])
    assignment = assignment.replace("{{EXAMPLE_FACT_1}}", domain["example_facts"][0])
    assignment = assignment.replace("{{EXAMPLE_FACT_2}}", domain["example_facts"][1])
    assignment = assignment.replace("{{EXAMPLE_FACT_3}}", domain["example_facts"][2])
    assignment = assignment.replace("{{EXAMPLE_RULE}}", domain["example_rules"][0])
    assignment = assignment.replace("{{EXAMPLE_QUERY}}", domain["example_query"])
    assignment = assignment.replace("{{EXPECTED_OUTPUT}}", domain["expected_output"])
    assignment = assignment.replace("{{MIN_FACTS}}", str(requirements["min_facts"]))
    assignment = assignment.replace("{{MIN_RULES}}", str(requirements["min_rules"]))
    assignment = assignment.replace("{{MIN_RECURSIVE}}", str(requirements["min_recursive_predicates"]))

    # Write personalized assignment
    output_path = repo_root / "ASSIGNMENT.md"
    output_path.write_text(assignment)
    print(f"Generated personalized assignment: {output_path}")


if __name__ == "__main__":
    main()
