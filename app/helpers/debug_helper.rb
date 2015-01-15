helpers do

  def debug_hash(label, object)

    if object.respond_to? :to_hash
      object = JSON.pretty_generate object.to_hash
    elsif object.respond_to? :to_a
      object = JSON.pretty_generate object.to_a
    end

    <<-HTML
<div class="debug">
<div class="debug--label">#{ escape_html label }</div>
<pre>#{ escape_html object.to_s }</pre>
</div>
    HTML
  end

end