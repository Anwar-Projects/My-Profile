#!/usr/bin/env python3
"""Link checker with retry logic for CI/CD"""

import requests
import time
from pathlib import Path
import re
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed

HEADERS = {'User-Agent': 'Mozilla/5.0 (compatible; LinkChecker/1.0)'}
TIMEOUT = 30
MAX_RETRIES = 3
RETRY_DELAY = 2

def check_url(url, attempt=1):
    """Check a single URL with retry logic."""
    try:
        response = requests.head(url, headers=HEADERS, timeout=TIMEOUT, allow_redirects=True)
        if response.status_code == 405:  # Method not allowed, try GET
            response = requests.get(url, headers=HEADERS, timeout=TIMEOUT, allow_redirects=True)
        return url, response.status_code, None
    except Exception as e:
        if attempt < MAX_RETRIES:
            time.sleep(RETRY_DELAY * attempt)
            return check_url(url, attempt + 1)
        return url, None, str(e)

def extract_urls(filepath):
    """Extract URLs from markdown/HTML files."""
    content = filepath.read_text(encoding='utf-8')
    # Match http/https URLs
    urls = re.findall(r'https?://[^\s\)\]\>\"\']+', content)
    # Filter out shields.io and camo URLs which are image proxies
    urls = [u for u in urls if 'shields.io' not in u and 'camo.githubusercontent' not in u]
    return list(set(urls))

def main():
    repo_root = Path(__file__).parent.parent
    md_files = list(repo_root.glob('*.md')) + list(repo_root.glob('**/*.md'))
    
    all_urls = []
    for f in md_files:
        all_urls.extend(extract_urls(f))
    all_urls = list(set(all_urls))
    
    if not all_urls:
        print("No URLs found.")
        return 0
    
    print(f"Checking {len(all_urls)} unique URLs...")
    failed = []
    
    with ThreadPoolExecutor(max_workers=10) as executor:
        futures = {executor.submit(check_url, url): url for url in all_urls}
        for future in as_completed(futures):
            url, status, error = future.result()
            if status and 200 <= status < 400:
                print(f"  ✓ {url} ({status})")
            else:
                print(f"  ✗ {url} ({status or 'ERROR'}) {error or ''}")
                failed.append((url, status, error))
    
    if failed:
        print(f"\n{len(failed)} URLs failed:")
        for url, status, error in failed:
            print(f"  - {url}: {status or error}")
        return 1
    
    print("\n✓ All links verified successfully!")
    return 0

if __name__ == '__main__':
    sys.exit(main())
