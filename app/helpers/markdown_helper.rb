module MarkdownHelper
  class SyntaxHighlight < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= :plaintext
      CodeRay.scan(code, language).div(span: :div)
    end
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(
      SyntaxHighlight,
      autolink: true,
      fenced_code_blocks: true,
      tables: true,
      strikethrough: true,
      no_intra_emphasis: true
      # space_after_headers: true, ヘッダのハッシュの後にスペースを必須にする
      # superscript: true キャレット^ によるスクリプトを無効
    )
    markdown.render(text).html_safe
  end
end
