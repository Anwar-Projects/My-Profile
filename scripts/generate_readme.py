#!/usr/bin/env python3
import yaml
import jinja2
from datetime import datetime
from pathlib import Path
import argparse
import sys

SCRIPT_DIR = Path(__file__).parent
REPO_ROOT = SCRIPT_DIR.parent
DATA_DIR = REPO_ROOT / "data"
TEMPLATES_DIR = REPO_ROOT / "templates"
OUTPUT_FILE = REPO_ROOT / "README.md"

def load_yaml_data(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)
    except FileNotFoundError:
        print(f"Error: Data file not found: {filepath}")
        sys.exit(1)
    except yaml.YAMLError as e:
        print(f"Error parsing YAML: {e}")
        sys.exit(1)

def render_template(template_path, data, theme="dark"):
    env = jinja2.Environment(
        loader=jinja2.FileSystemLoader(str(template_path.parent)),
        trim_blocks=True,
        lstrip_blocks=True
    )
    template = env.get_template(template_path.name)
    context = {**data, 'generation_date': datetime.now().strftime('%Y-%m-%d %H:%M:%S'), 'theme': theme}
    return template.render(**context)

def validate_data(data):
    required_keys = ["personal", "summary", "skills", "certifications"]
    for key in required_keys:
        if key not in data:
            print(f"Error: Missing required key '{key}' in profile data")
            return False
    return True

def main():
    parser = argparse.ArgumentParser(description='Generate README from template')
    parser.add_argument('--theme', default='dark', choices=['dark', 'light', 'high-contrast'])
    parser.add_argument('--output', type=Path, default=OUTPUT_FILE)
    parser.add_argument('--validate-only', action='store_true')
    args = parser.parse_args()
    
    print("Loading profile data...")
    data = load_yaml_data(DATA_DIR / 'profile.yaml')
    
    print("Validating data...")
    if not validate_data(data):
        sys.exit(1)
    
    if args.validate_only:
        print("Data validation passed")
        return
    
    print(f"Rendering template with theme: {args.theme}...")
    template_path = TEMPLATES_DIR / 'README.md.j2'
    if not template_path.exists():
        print(f"Error: Template not found: {template_path}")
        sys.exit(1)
    
    output = render_template(template_path, data, args.theme)
    
    print(f"Writing to {args.output}...")
    with open(args.output, 'w', encoding='utf-8') as f:
        f.write(output)
    
    print("README generated successfully!")

if __name__ == '__main__':
    main()
