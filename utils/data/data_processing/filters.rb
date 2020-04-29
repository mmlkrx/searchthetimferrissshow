module DataProcessing
  module Filters
    TRANSCRIPT_HTML_URL = '//p/a[contains(@href, "transcript")]'
    TRANSCRIPT_HTML_TEXT = '//div[@class="entry-content"]/p[strong[contains(text(), ":")]]'
  end
end
