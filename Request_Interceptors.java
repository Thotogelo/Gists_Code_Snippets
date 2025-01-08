//Create The interceptor class
@Component
public class IncomingRequestLogFilter implements HandlerInterceptor {
    private static final Logger LOGGER = LogManager.getLogger(IncomingRequestLogFilter.class);

    //    Intercept and Log request
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        LOGGER.info("Incoming request - IP:{},  Method: {}, URI: {}", request.getRemoteAddr(), request.getMethod(), request.getRequestURI());
        return true;
    }
}

//Register the interceptor
@Configuration
public class ConfigMiddleInterceptor implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new IncomingRequestLogFilter());
    }
}
