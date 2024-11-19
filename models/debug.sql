{% do log('Current target: ' ~ target.name, info=True) %}
select '{{ target.name }}' as current_target
