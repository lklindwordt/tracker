module ProjectsHelper
  def feedback_snippet(project)
    js = "javascript:(function() {
      var script = document.createElement('script');
      script.type = 'text/javascript';
      script.src = 'http://#{request.host}/assets/client.js?' + (new Date().getTime()) + '&projectId=#{project.id}';
      document.getElementsByTagName('body')[0].appendChild(script);
    }()); return false;
    "
      .gsub(/;\s+/,';')
      .gsub(/\s*=\s*/,'=')
      .gsub(/\s*\+\s*/,'+')
    "<a href='#' onclick=\"#{js}\">Feedback</a>"
  end
end
