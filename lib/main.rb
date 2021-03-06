module Main
  require "rswing"

  include RSwing::Components
  
  # geht genauso wie die 'normale' variante:
  # frame = Frame.new("hallo, welt")
  # ... # hier dann einfach auch zugriffe auf frame
  Frame.new("hallo, welt", :size => [800, 600]) do |frame|
    frame.default_close_operation = :exit_on_close

    Panel.new(java.awt.GridLayout.new(1,1), :size => [300, 500], :name => :panel, :belongs_to => frame) do |panel|
      Button.new("test", :belongs_to => panel, :name => :testButton) do |btn|
        btn.on_click do
          Dialog.showOption "bitte auswählen:", :option_type => :yes_no, :option_values => ["Aha", "ohno"],
            :title => "auswahl treffen!", :belongs_to => frame
        end

        btn.on_click do
          Dialog.show("mein text", :dialog_type => :error, :title => "hello, world", :belongs_to => frame)
        end


        btn.on_focus do
          puts "button hat jetzt focus"
        end

        btn.on_focus_lost do
          puts "button hat focus verloren"
        end
      end

      puts "text von testButton: #{panel[:testButton].text}"
    end

    #frame.size = [400, 400]

    options = ["Herr", "Frau", "Geek"]
    selected_value = Dialog.showOption(options.join(" oder ") + "?",
      :option_values => options, :option_type => :yes_no_cancel, :belongs_to => frame)
    
    puts "#{selected_value} wurde ausgewählt"

    frame.visible = true
  end

  # dialog testen
  Dialog.new("mein titel", :modal => true) do |dial|
    Button.new("click me", :belongs_to => dial, :name => :clickButton) do |button|
      button.on_click do
        Dialog.show("test dialog", :dialog_type => :info, :title => "hey, was geht?")
      end
    end
    
    dial.size = java.awt.Dimension.new(300,300)
    dial.visible = true
  end
  
end