---
layout: default
title: Resume
slug: resume
base_url: "../"
---

Resume {.page-header}
===

<p class="alert">A pdf version of my resume is available <a href="{{ page.base_url}}static/downloads/alekskamko_resume.pdf">here</a>.</p>
Experience {.sub-heading}
---
{% for exp in site.experience %}

### {{ exp.position }} @ {{ exp.organization }}
#### ({{exp.start}} - {{exp.end}})
{% for blurb in exp.blurbs %}* {{ blurb }}
{% endfor %}

{% endfor %}

<div class="bm3-5"> </div>

Education {.sub-heading}
---
{% for ed in site.education %}

### {{ ed.degree }}
#### {{ ed.place }}<span class="midbar">|</span>{% if ed.expected %}Expected: *{{ ed.expected }}*{% elsif ed.recieved %}Recieved: *{{ ed.recieved }}*{% endif %}
{% for exp in ed.relevant_experience %}* {{ exp }}
{% endfor %}
{% endfor %}

<div class="bm3-5"> </div>

Skills {.sub-heading}
---
#### Proficient in:
* {{ site.skills.proficient | array_to_sentence_string }}

#### Experience in:
* {{ site.skills.experience | array_to_sentence_string }}

#### Exposure to:
* {{ site.skills.exposure | array_to_sentence_string }}

#### Other skills:
* {{ site.skills.other | array_to_sentence_string }}

<div class="bm3-5"> </div>

Projects {.sub-heading}
---
{% for project in site.projects limit:5 %}
### {{ project.name }} {% if project.url %}<a href="{{ project.url|safe }}">(demo)</a>{% endif %} {% if project.repo %}<a href="{{ project.repo }}">(repo)</a>{% endif %}

{{ project.description }}

{% endfor %}

<div class="bm3-5"> </div>

Leadership {.sub-heading}
---
{% for role in site.leadership %}

### {{ role.position }} @ {{ role.organization }}
#### ({{role.term}})
{% for blurb in role.blurbs %}* {{ blurb }}
{% endfor %}

{% endfor %}
