from datetime import datetime

AUTHOR = 'Julian Harttung'
SITENAME = 'Sheet Music'
SITESUBTITLE = 'A collection sheet music written in MusiXTeX'
COPYRIGHT = datetime.now().year
SITEURL = ""

PATH = "content"

TIMEZONE = 'Europe/Berlin'

DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# No tag generation
TAGS_SAVE_AS = ''
TAG_SAVE_AS = ''

# Blogroll
LINKS = ()

# Social widget
SOCIAL = (
    ("github", "https://github.com/huljar"),
    ("medium", "https://medium.com/@huljar"),
)

GITHUB_URL = "https://github.com/huljar/sheet-music"

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True

# Custom theme
THEME = 'themes/Peli-Kiera'
