package hello.filters.pre;

import com.google.common.io.CharStreams;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class SimpleFilter extends ZuulFilter {

  private static Logger log = LoggerFactory.getLogger(SimpleFilter.class);

  @Override
  public String filterType() {
    return "post";
  }

  @Override
  public int filterOrder() {
    return 1;
  }

  @Override
  public boolean shouldFilter() {
    return true;
  }

  @Override
  public Object run() {
    RequestContext ctx = RequestContext.getCurrentContext();
    HttpServletResponse response = ctx.getResponse();
    String respbody = ctx.getResponseBody();
    HttpServletRequest request = ctx.getRequest();

    log.info(String.format("%s request to %s", request.getMethod(), request.getRequestURL().toString()));
    log.info("status {}", response.getStatus());
    try (final InputStream responseDataStream = ctx.getResponseDataStream()) {
      final String responseData = CharStreams.toString(new InputStreamReader(responseDataStream, "UTF-8"));
      log.info("body {}",responseData);
      ctx.setResponseBody(responseData);
    } catch (IOException e) {
      log.warn("Error reading body",e);
    }
    return null;
  }

}
