module ProjectsHelper
  def feedback_snippet(project)
    js = "
      javascript:( function() {
         var script = document.createElement('script');
         script.type = 'text/javascript';
         script.src = 'http://#{request.host}/assets/client.js?' + (new Date().getTime()) + '&project_id=#{project.id}';
         document.getElementsByTagName('body')[0].appendChild(script);
       })()
    ".gsub(/\s/,'')
    "<a href='#' click='#{js}'>Feedback</a>"
  end
end
