#!/usr/bin/env python3
"""
Variant Generator for Project 4: Expert System
CSC3301 Programming Language Paradigms

Generates unique expert system domain based on student ID.
Each student gets a deterministic domain assignment.
"""
import hashlib
import json
import sys
import random
from pathlib import Path


# Domain definitions with full details
DOMAINS = {
    "medical": {
        "name": "Medical Diagnosis",
        "description": "Build an expert system that diagnoses common illnesses based on symptoms",
        "main_predicate": "diagnose/2",
        "example_facts": [
            "symptom(patient1, fever)",
            "symptom(patient1, cough)",
            "symptom(patient1, fatigue)"
        ],
        "example_rules": [
            "diagnose(Patient, flu) :- symptom(Patient, fever), symptom(Patient, cough), symptom(Patient, fatigue)",
            "diagnose(Patient, cold) :- symptom(Patient, runny_nose), symptom(Patient, sneezing)"
        ],
        "example_query": "?- diagnose(patient1, Disease).",
        "expected_output": "Disease = flu."
    },
    "career": {
        "name": "Career Advisor",
        "description": "Build an expert system that recommends careers based on skills and interests",
        "main_predicate": "recommend_career/2",
        "example_facts": [
            "skill(alice, programming)",
            "skill(alice, mathematics)",
            "interest(alice, technology)"
        ],
        "example_rules": [
            "recommend_career(Person, software_developer) :- skill(Person, programming), interest(Person, technology)",
            "recommend_career(Person, data_scientist) :- skill(Person, mathematics), skill(Person, programming)"
        ],
        "example_query": "?- recommend_career(alice, Career).",
        "expected_output": "Career = software_developer."
    },
    "plants": {
        "name": "Plant Identifier",
        "description": "Build an expert system that identifies plants based on characteristics",
        "main_predicate": "identify_plant/2",
        "example_facts": [
            "has_feature(sample1, needle_leaves)",
            "has_feature(sample1, cones)",
            "has_feature(sample1, evergreen)"
        ],
        "example_rules": [
            "identify_plant(Sample, pine_tree) :- has_feature(Sample, needle_leaves), has_feature(Sample, cones)",
            "identify_plant(Sample, oak_tree) :- has_feature(Sample, broad_leaves), has_feature(Sample, acorns)"
        ],
        "example_query": "?- identify_plant(sample1, Plant).",
        "expected_output": "Plant = pine_tree."
    },
    "recipes": {
        "name": "Recipe Suggester",
        "description": "Build an expert system that suggests recipes based on available ingredients",
        "main_predicate": "suggest_recipe/2",
        "example_facts": [
            "has_ingredient(kitchen1, eggs)",
            "has_ingredient(kitchen1, flour)",
            "has_ingredient(kitchen1, milk)"
        ],
        "example_rules": [
            "suggest_recipe(Kitchen, pancakes) :- has_ingredient(Kitchen, eggs), has_ingredient(Kitchen, flour), has_ingredient(Kitchen, milk)",
            "suggest_recipe(Kitchen, omelette) :- has_ingredient(Kitchen, eggs), has_ingredient(Kitchen, cheese)"
        ],
        "example_query": "?- suggest_recipe(kitchen1, Recipe).",
        "expected_output": "Recipe = pancakes."
    },
    "tech_support": {
        "name": "Tech Support",
        "description": "Build an expert system that diagnoses computer problems and suggests solutions",
        "main_predicate": "diagnose_problem/2",
        "example_facts": [
            "symptom(computer1, slow_performance)",
            "symptom(computer1, high_cpu_usage)",
            "symptom(computer1, many_processes)"
        ],
        "example_rules": [
            "diagnose_problem(Device, malware) :- symptom(Device, slow_performance), symptom(Device, high_cpu_usage)",
            "diagnose_problem(Device, insufficient_ram) :- symptom(Device, slow_performance), symptom(Device, many_processes)"
        ],
        "example_query": "?- diagnose_problem(computer1, Problem).",
        "expected_output": "Problem = malware."
    },
    "animals": {
        "name": "Animal Classifier",
        "description": "Build an expert system that classifies animals based on characteristics",
        "main_predicate": "classify_animal/2",
        "example_facts": [
            "has_trait(creature1, has_feathers)",
            "has_trait(creature1, can_fly)",
            "has_trait(creature1, lays_eggs)"
        ],
        "example_rules": [
            "classify_animal(Creature, bird) :- has_trait(Creature, has_feathers), has_trait(Creature, lays_eggs)",
            "classify_animal(Creature, mammal) :- has_trait(Creature, has_fur), has_trait(Creature, gives_milk)"
        ],
        "example_query": "?- classify_animal(creature1, Type).",
        "expected_output": "Type = bird."
    }
}


def generate_variant(student_id: str) -> dict:
    """
    Generate a unique variant configuration based on student ID.

    Uses deterministic hashing so the same student ID always
    produces the same variant.
    """
    # Create deterministic seed from student ID
    seed = int(hashlib.sha256(student_id.encode()).hexdigest(), 16) % (2**32)
    rng = random.Random(seed)

    # Select domain deterministically
    domain_keys = list(DOMAINS.keys())
    domain_index = seed % len(domain_keys)
    domain_key = domain_keys[domain_index]
    domain = DOMAINS[domain_key]

    # Generate additional variant-specific values
    min_facts = rng.choice([25, 30, 35])
    min_rules = rng.choice([12, 15, 18])
    min_recursive = rng.choice([3, 4, 5])

    variant = {
        "student_id": student_id,
        "variant_seed": seed,
        "domain": {
            "key": domain_key,
            "name": domain["name"],
            "description": domain["description"],
            "main_predicate": domain["main_predicate"],
            "example_facts": domain["example_facts"],
            "example_rules": domain["example_rules"],
            "example_query": domain["example_query"],
            "expected_output": domain["expected_output"]
        },
        "requirements": {
            "min_facts": min_facts,
            "min_rules": min_rules,
            "min_recursive_predicates": min_recursive
        }
    }

    return variant


def update_prolog_files(variant: dict, repo_root: Path):
    """
    Update Prolog source files with variant-specific configuration.
    """
    domain = variant["domain"]

    # Update knowledge_base.pl with domain-specific template comments
    kb_path = repo_root / "src" / "knowledge_base.pl"
    if kb_path.exists():
        content = kb_path.read_text()

        # Add domain-specific header comment if not present
        if "YOUR DOMAIN:" not in content:
            domain_header = f"""% Expert System Knowledge Base
% YOUR DOMAIN: {domain['name']}
% Description: {domain['description']}
%
% Example facts for your domain:
% {domain['example_facts'][0]}
% {domain['example_facts'][1]}
%
% Add at least {variant['requirements']['min_facts']} facts below

"""
            content = domain_header + content
            kb_path.write_text(content)
            print(f"Updated {kb_path}")

    # Update rules.pl with domain-specific template
    rules_path = repo_root / "src" / "rules.pl"
    if rules_path.exists():
        content = rules_path.read_text()

        if "YOUR DOMAIN:" not in content:
            rules_header = f"""% Expert System Rules
% YOUR DOMAIN: {domain['name']}
% Main predicate: {domain['main_predicate']}
%
% Example rules:
% {domain['example_rules'][0]}
%
% Add at least {variant['requirements']['min_rules']} rules below

"""
            content = rules_header + content
            rules_path.write_text(content)
            print(f"Updated {rules_path}")


def main():
    if len(sys.argv) < 2:
        print("Usage: python variant_generator.py <student_id>")
        print("Example: python variant_generator.py john_doe")
        sys.exit(1)

    student_id = sys.argv[1]
    repo_root = Path(__file__).parent.parent

    print(f"Generating variant for student: {student_id}")

    # Generate variant
    variant = generate_variant(student_id)

    # Save variant config
    config_path = repo_root / ".variant_config.json"
    with open(config_path, 'w') as f:
        json.dump(variant, f, indent=2)
    print(f"Saved variant config to {config_path}")

    # Update Prolog source files with variant values
    update_prolog_files(variant, repo_root)

    # Display summary
    print("\n=== Variant Summary ===")
    print(f"Student ID: {variant['student_id']}")
    print(f"Seed: {variant['variant_seed']}")
    print(f"Domain: {variant['domain']['name']}")
    print(f"Main Predicate: {variant['domain']['main_predicate']}")
    print(f"Min Facts: {variant['requirements']['min_facts']}")
    print(f"Min Rules: {variant['requirements']['min_rules']}")
    print(f"Min Recursive Predicates: {variant['requirements']['min_recursive_predicates']}")


if __name__ == "__main__":
    main()
