require "redcarpet"
require "front_matter_parser"

module MarkdownHandler
  def self.erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  def self.call(template, source)
    if source.strip.start_with?("---")
      parsed = FrontMatterParser::Parser.parse_file(template.identifier)
      source = parsed.content
      front_matter = parsed.front_matter

      compiled_source = erb.call(template, source)

      <<-RUBY
        content_for :front_matter, #{front_matter.inspect} if defined?(content_for)
        @front_matter = #{front_matter.inspect}
        markdown = Redcarpet::Markdown.new(
          Redcarpet::Render::HTML.new(
            filter_html: false,
            no_intra_emphasis: true,
            tables: true,
            fenced_code_blocks: true,
            autolink: true,
            strikethrough: true,
            superscript: true
          )
        )
        markdown.render((begin;#{compiled_source};end).to_s).html_safe
      RUBY
    else
      compiled_source = erb.call(template, source)
      <<-RUBY
        markdown = Redcarpet::Markdown.new(
          Redcarpet::Render::HTML.new(
            filter_html: false,
            no_intra_emphasis: true,
            tables: true,
            fenced_code_blocks: true,
            autolink: true,
            strikethrough: true,
            superscript: true
          )
        )
        markdown.render((begin;#{compiled_source};end).to_s).html_safe
      RUBY
    end
  end
end

ActionView::Template.register_template_handler :md, MarkdownHandler
