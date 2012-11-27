Pseudohelp.configure do |config|

  config.custom_compilers = {
    bbcode: ThreddedBbcode
  }

  config.extra_help = {
    markdown: {
      code: {
        'Github flavored code' => <<-mkdn
          ```ruby
            def greeting
              puts 'Hello! Hola! Bom dia!'
            end
          ```
        mkdn
      }
    },
    bbcode: {
      code: {
        'Code with lang' => '[code:javascript]function(){ return true; }[/code]',
        'Spoilers' => '[spoiler]Soylent green is people.[/spoiler]',
        'Youtube' => '[youtube]http://www.youtube.com/watch?v=123456[/youtube]'
      }
    },
    thredded: {
      images: {
        'Next image attached to post' => '[t:img]',
        'Second image attached to post' => '[t:img=2]',
        'Align second and third images attached to post' => '[t:img=2 left] [t:img=3 right]',
        'Specify size on the fourth attached image' =>  '[t:img=4 200x200]'
      }
    }
  }
end
