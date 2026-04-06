from __future__ import annotations

import html
import re
import urllib.error
import urllib.request

URL = "https://www.zaobao.com/"
USER_AGENT = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/124.0.0.0 Safari/537.36"
)
MAX_TITLES = 5


def fetch_homepage(url: str) -> str:
    request = urllib.request.Request(
        url,
        headers={
            "User-Agent": USER_AGENT,
            "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
        },
    )
    with urllib.request.urlopen(request, timeout=20) as response:
        charset = response.headers.get_content_charset() or "utf-8"
        return response.read().decode(charset, errors="replace")


def clean_text(raw_text: str) -> str:
    text = re.sub(r"<[^>]+>", "", raw_text)
    text = html.unescape(text)
    text = re.sub(r"\s+", " ", text).strip()
    return text


def extract_titles(page_html: str, limit: int = MAX_TITLES) -> list[str]:
    heading_matches = re.findall(r"<h[1-6][^>]*>(.*?)</h[1-6]>", page_html, re.I | re.S)

    titles: list[str] = []
    seen: set[str] = set()

    for match in heading_matches:
        title = clean_text(match)
        if not title:
            continue
        if len(title) < 8:
            continue
        if title in seen:
            continue

        seen.add(title)
        titles.append(title)

        if len(titles) >= limit:
            break

    return titles


def main() -> None:
    try:
        page_html = fetch_homepage(URL)
        titles = extract_titles(page_html)
    except urllib.error.URLError as exc:
        print(f"Failed to fetch {URL}: {exc}")
        return

    if not titles:
        print("No news titles were found.")
        return

    print("Top 5 Zaobao news titles:")
    for index, title in enumerate(titles, start=1):
        print(f"{index}. {title}")


if __name__ == "__main__":
    main()
