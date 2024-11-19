-- -- -- -- -- -- -- 
-- basic Jinja
-- -- -- -- -- -- -- 
{% set my_cool_string = 'wow' %}
{% set my_second_cool_string = 'this is jinja' %}
{% set my_cool_number = 100 %}

{{ my_cool_string }}
{{ my_second_cool_string }}
{{ my_cool_number }}
{{ my_cool_string }}{{ my_second_cool_string }}I want to write Jinja for {{ my_cool_number }} hours!

-- -- -- -- -- -- -- 
-- For Loop
-- -- -- -- -- -- -- 
{% set my_animals = ['monkey', 'wolf', 'rabbit', 'tiger'] %}

{{ my_animals[0] }}

{% for animal in my_animals %}
    my favorite animal is the {{ animal }}
{% endfor %}

-- -- -- -- -- -- -- 
-- For Loop 2
-- -- -- -- -- -- -- 

{% for i in range(10) %}

    select {{ i }} as number {% if not loop.last %} union all {% endif %}

{% endfor %};


-- -- -- -- -- -- -- 
-- IF ELSE
-- -- -- -- -- -- -- 
{% set temp = 70 %}
{% if temp < 65 %}
    time for a cappuccino!
{% else %}
    time for a cold brew!
{% endif %}

-- -- -- -- -- -- -- 
-- LISTS
-- -- -- -- -- -- -- 
{% set foods = ['carrot', 'hotdog', 'cucumber', 'potato']%}

{% for food in foods %}

    {% if food == 'carrot' %}
        {% set food_type = 'snack'%}
    {% else %}
        {% set food_type = 'vegetable' %}
    {% endif%}

    The humble {{ food }} is my favorite {{ food_type }}

{% endfor %}

-- -- -- -- -- -- -- 
-- DICTIONARIES
-- -- -- -- -- -- -- 

{% set websters_dict = {
    'word': 'data',
    'speech_part': 'noun',
    'definition': 'if you know you know'
}%}

{{ websters_dict['word']}}
 