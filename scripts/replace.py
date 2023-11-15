import os
import shutil
import re
import fnmatch
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Update this before running the script
search_term = "Aggregated Correlation"
excluded_terms = ["Aggregate Correlation", "Correlation Coefficient"]
replace_term = "Global Variable Relationship"

target_directory = "C:\\Users\\User\\OneDrive\\code\\decentralized-fda"  # Replace with actual path

allowed_extensions = ['.md', '.php', '.ts', '.js', '.html', '.css', '.yml', '.txt', '.md',
                      # '.py',
                      '.java',
                      '.cpp', '.c', '.cs', '.json', '.xml', '.yaml', '.yml', '.sh', '.bat']
excluded_dirs = [".git", ".svn", ".idea"]


def generate_case_variations(term):
  """
    Generate variations of the term in different cases:
    camelCase, snake_case, kebab-case, title case, lower case, upper case, SCREAMING_SNAKE_CASE.
    """
  lower_case = term.lower()
  upper_case = term.upper()
  title_case = term.title()
  camel_case = lower_case[0].lower() + title_case[1:]
  snake_case = lower_case.replace(' ', '_')
  screaming_snake_case = upper_case.replace(' ', '_')
  kebab_case = lower_case.replace(' ', '-')
  return [lower_case, title_case, camel_case, snake_case, kebab_case, upper_case, screaming_snake_case]


def create_regex_pattern(terms):
  """
    Create a regex pattern that matches any of the terms in their various cases.
    """
  escaped_terms = [re.escape(term) for term in terms]
  pattern = '|'.join(escaped_terms)
  return re.compile(pattern, re.IGNORECASE)


def rename_entity(path, search_pattern, replace_term):
  """
    Rename a file or directory if it matches the search pattern.
    """
  entity_name = os.path.basename(path)
  new_name = search_pattern.sub(replace_term, entity_name)
  if new_name != entity_name:
    new_path = os.path.join(os.path.dirname(path), new_name)
    shutil.move(path, new_path)
    logging.info(f'Renamed: {path} -> {new_path}')
    return new_path
  return path


def is_excluded(match, excluded_patterns):
  """
    Check if the regex match is part of any of the excluded patterns.
    """
  start, end = match.span()
  for pattern in excluded_patterns:
    if pattern.search(match.string, pos=start, endpos=end):
      return True
  return False


def parse_gitignore(gitignore_path):
  """
    Parse a .gitignore file and return a list of patterns to ignore.
    """
  ignore_patterns = []
  with open(gitignore_path, 'r') as file:
    for line in file:
      stripped_line = line.strip()
      if stripped_line and not stripped_line.startswith('#'):
        ignore_patterns.append(stripped_line)
  return ignore_patterns


def find_gitignore_patterns(start_path):
  """
    Find and parse .gitignore files from the target directory up to the root.
    """
  patterns = []
  current_path = start_path

  while True:
    gitignore_path = os.path.join(current_path, '.gitignore')
    if os.path.isfile(gitignore_path):
      patterns.extend(parse_gitignore(gitignore_path))

    new_path = os.path.dirname(current_path)
    if new_path == current_path:
      break
    current_path = new_path

  return patterns


def should_ignore(path, ignore_patterns, root_dir):
  """
  Check if a file or directory should be ignored based on .gitignore patterns.
  """
  relative_path = os.path.relpath(path, root_dir)
  for pattern in ignore_patterns:
    if fnmatch.fnmatch(relative_path, pattern) or fnmatch.fnmatch(os.path.basename(path), pattern):
      return True
  return False


def apply_case(original, template):
  """
  Apply the case of the original word to the template word.
  """
  if original.islower():
    return template.lower()
  elif original.isupper():
    return template.upper()
  elif original.istitle():
    return template.title()
  elif original.islower() == False and original.isupper() == False:  # camelCase
    return template[0].lower() + template[1:]
  else:
    return template  # Default case


def replace_in_file(file_path, search_pattern, replace_term, excluded_patterns):
  with open(file_path, 'r', encoding='utf-8') as file:
    content = file.read()

  def replace_func(match):
    if is_excluded(match, excluded_patterns):
      return match.group()
    return apply_case(match.group(), replace_term)

  logging.info(f'Checking: {file_path}')

  new_content = search_pattern.sub(replace_func, content)
  if new_content != content:
    with open(file_path, 'w', encoding='utf-8') as file:
      file.write(new_content)
    logging.info(f'Modified: {file_path}')

  def should_ignore(path, ignore_patterns, root_dir):
    """
    Check if a file or directory should be ignored based on .gitignore patterns.
    """
    relative_path = os.path.relpath(path, root_dir)
    for pattern in ignore_patterns:
      if fnmatch.fnmatch(relative_path, pattern) or fnmatch.fnmatch(os.path.basename(path), pattern):
        return True
    return False


def process_directory(directory, search_pattern, replace_term, excluded_patterns, allowed_extensions, excluded_dirs):
  """
  Process each file and directory within the specified directory, respecting .gitignore rules.
  """
  ignore_patterns = find_gitignore_patterns(directory)
  excluded_directories = {os.path.join(directory, d) for d in excluded_dirs}

  for root, dirs, files in os.walk(directory, topdown=True):
    dirs[:] = [d for d in dirs if
               not should_ignore(os.path.join(root, d), ignore_patterns, directory) and os.path.join(root,
                                                                                                     d) not in excluded_directories]

    for name in files:
      file_path = os.path.join(root, name)
      if should_ignore(file_path, ignore_patterns, directory):
        continue

      extension = os.path.splitext(file_path)[1].lower()
      if extension in allowed_extensions:
        replace_in_file(file_path, search_pattern, replace_term, excluded_patterns)

    for name in dirs:
      dir_path = os.path.join(root, name)
      rename_entity(dir_path, search_pattern, replace_term)


# Generate regex patterns for the search term and excluded terms
search_pattern = create_regex_pattern(generate_case_variations(search_term))
excluded_patterns = [create_regex_pattern(generate_case_variations(term)) for term in excluded_terms]

# Process the directory
process_directory(target_directory, search_pattern, replace_term, excluded_patterns, allowed_extensions, excluded_dirs)
