@key = 'registered_aliases'
@prevAliases = get_value(@key)
# Ensure
if (!@prevAliases) {
    @prevAliases = array()
}
set_timeout(0, closure() {
    @completes = array()
    foreach (@alias in get_aliases()) {
        @name = substr(
            @alias,
            string_position(@alias, '/') + 1,
            string_position(@alias, ' ')
        )
        if (!array_contains(@prevAliases, @name)) {
            register_command(@name, array(
                'tabcompleter': closure() {}
            ))
        }
        array_push(@completes, @name)
    }
    foreach (@name in @prevAliases) {
        if (!array_contains(@completes, @name)) {
            unregister_command(@name)
        }
    }
    store_value(@key, @completes)
})