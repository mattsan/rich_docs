class Chapter < ApplicationRecord
  has_rich_text :content

  def to_xhtml
    html = Nokogiri::HTML.parse(content.body.to_s, nil, 'utf-8')
    html.title = title

    html.xpath('//div/action-text-attachment').each do |attachment|
      data = attachment['url'].match(%r{/(?<signed_id>[^/]+)/(?<filename>[^/]+)$})
      blob_id = ActiveStorage.verifier.verify(data[:signed_id], purpose: :blob_id)
      attachment.replace(%Q(<img src="../img/#{blob_id}/#{data[:filename]}">))
    end

    html.to_xhtml
  end
end
