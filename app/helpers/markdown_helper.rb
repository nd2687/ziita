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
# ヘッダのハッシュの後にスペースを必須にする
#      space_after_headers: true,
      fenced_code_blocks: true,
      tables: true,
      strikethrough: true,
# キャレット^ によるスクリプトを無効
#      superscript: true
    )
    markdown.render(text).html_safe
  end
end
