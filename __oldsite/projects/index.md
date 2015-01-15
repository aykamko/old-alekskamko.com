---
layout: default
title: Projects
slug: projects
base_url: "../"
---

Projects {.page-header}
===

{% for project in site.projects %}

###{{ project.name }}{% if project.url %}<a href="{{ project.url }}">  (demo)</a>{% endif %}{% if project.repo %}<a href="{{ project.repo }}">  (repo)</a>{% endif %} { .sub-heading }

{{ project.description }}

{% if project.images %}
<div class="project-image-div">
  <ul>
    {% for img in project.images %}
      <li><a href="{{ page.base_url }}static/img/{{ img }}" data-lightbox="{{ project.name }}">
        <img class="hidden project-image" src="{{ page.base_url }}static/img/{{ img }}"/>
      </a></li>
    {% endfor %}
  </ul>
</div>
{% endif %}

{% if forloop.last != true %}
<div class="bm3-5"> </div>
{% else %}
<div class="project-footer-filler"> </div>
{% endif %}

{% endfor %}

<script type="text/javascript">
  $('.project-image-div').each(function() {
    var totalImageWidth = 0;
    var finished = 0;
    var $imgArray = $(this).children('ul').find('img');
    var imgLength = $imgArray.length;
    $imgArray.each(function () {
      $(this).on('load', function() {
        totalImageWidth += this.width;
        finished += 1;
        if (finished == imgLength) {
          $imgArray.each(function () {
            $(this).width(100 * (this.width / totalImageWidth) + "%");
            $(this).removeClass("hidden");
          });
        }
      });
    });
  });
</script>
