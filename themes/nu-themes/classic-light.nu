# Update terminal colors
export def "update terminal" [] {
    let theme = (main)

    # Set terminal colors
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'
        
    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    # Line breaks above are just for source readability
    # but create extra whitespace when activating. Collapse
    # to one line
    | str replace --all "\n" ''
    | print $in
}

# Update the Nushell configuration
export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

# Retrieve the theme settings
export def main [] {
    return {
        separator: '#303030'
        leading_trailing_space_bg: { attr: 'n' }
        header: { fg: '#90a959' attr: 'b' }
        empty: '#6a9fb5'
        bool: {|| if $in { '#75b5aa' } else { 'light_gray' } }
        int: '#303030'
        filesize: {|e|
            if $e == 0b {
                '#303030'
            } else if $e < 1mb {
                '#75b5aa'
            } else {{ fg: '#6a9fb5' }}
        }
        duration: '#303030'
        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#ac4142' attr: 'b' }
            } else if $in < 6hr {
                '#ac4142'
            } else if $in < 1day {
                '#f4bf75'
            } else if $in < 3day {
                '#90a959'
            } else if $in < 1wk {
                { fg: '#90a959' attr: 'b' }
            } else if $in < 6wk {
                '#75b5aa'
            } else if $in < 52wk {
                '#6a9fb5'
            } else { 'dark_gray' }
        }
        range: '#303030'
        float: '#303030'
        string: '#303030'
        nothing: '#303030'
        binary: '#303030'
        cellpath: '#303030'
        row_index: { fg: '#90a959' attr: 'b' }
        record: '#303030'
        list: '#303030'
        block: '#303030'
        hints: 'dark_gray'
        search_result: { fg: '#ac4142' bg: '#303030' }

        shape_and: { fg: '#aa759f' attr: 'b' }
        shape_binary: { fg: '#aa759f' attr: 'b' }
        shape_block: { fg: '#6a9fb5' attr: 'b' }
        shape_bool: '#75b5aa'
        shape_custom: '#90a959'
        shape_datetime: { fg: '#75b5aa' attr: 'b' }
        shape_directory: '#75b5aa'
        shape_external: '#75b5aa'
        shape_externalarg: { fg: '#90a959' attr: 'b' }
        shape_filepath: '#75b5aa'
        shape_flag: { fg: '#6a9fb5' attr: 'b' }
        shape_float: { fg: '#aa759f' attr: 'b' }
        shape_garbage: { fg: '#FFFFFF' bg: '#FF0000' attr: 'b' }
        shape_globpattern: { fg: '#75b5aa' attr: 'b' }
        shape_int: { fg: '#aa759f' attr: 'b' }
        shape_internalcall: { fg: '#75b5aa' attr: 'b' }
        shape_list: { fg: '#75b5aa' attr: 'b' }
        shape_literal: '#6a9fb5'
        shape_match_pattern: '#90a959'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#75b5aa'
        shape_operator: '#f4bf75'
        shape_or: { fg: '#aa759f' attr: 'b' }
        shape_pipe: { fg: '#aa759f' attr: 'b' }
        shape_range: { fg: '#f4bf75' attr: 'b' }
        shape_record: { fg: '#75b5aa' attr: 'b' }
        shape_redirection: { fg: '#aa759f' attr: 'b' }
        shape_signature: { fg: '#90a959' attr: 'b' }
        shape_string: '#90a959'
        shape_string_interpolation: { fg: '#75b5aa' attr: 'b' }
        shape_table: { fg: '#6a9fb5' attr: 'b' }
        shape_variable: '#aa759f'

        background: '#f5f5f5'
        foreground: '#303030'
        cursor: '#303030'
    }
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

# Activate the theme when sourced
use activate