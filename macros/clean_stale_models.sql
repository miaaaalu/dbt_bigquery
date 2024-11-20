{#  
    -- let's develop a macro that 
    1. queries the information schema of a database
    2. finds objects that are > 1 week old (no longer maintained)
    3. generates automated drop statements
    4. has the ability to execute those drop statements

#}

{% macro clean_stale_models(database=target.database, schema=target.schema, days=7, dry_run=True) %}

    {% set get_drop_commands_query %}
        select
            case 
                when table_type = 'VIEW'
                    then 'VIEW'
                else 
                    'TABLE'
            end as drop_type, 
            'DROP ' || drop_type || ' `' || '{{ database }}' || '.' || table_schema || '.' || table_name || '`;' as drop_command
        from `{{ database }}.{{ schema }}.INFORMATION_SCHEMA.TABLES`
        where creation_time <= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL {{ days }} DAY)
    {% endset %}

    {{ log('\nGenerating cleanup queries...\n', info=True) }}
    {% set drop_queries = run_query(get_drop_commands_query).table %}

    {% for row in drop_queries %}
        {% set query = row[1] %}   
        {% if dry_run %}
            {{ log(query, info=True) }}
        {% else %}
            {{ log('Dropping object with command: ' ~ query, info=True) }}
            {% do run_query(query) %} 
        {% endif %}
    {% endfor %}
    
{% endmacro %}
