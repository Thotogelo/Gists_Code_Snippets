using Microsoft.AspNetCore.HttpLogging;

namespace Enviro365Assessment_Jnr_DOTNET.Logging
{
    public class LoggingInterceptor : IHttpLoggingInterceptor
    {
        public ValueTask OnRequestAsync(HttpLoggingInterceptorContext logContext)
        {
            throw new NotImplementedException();
        }

        public ValueTask OnResponseAsync(HttpLoggingInterceptorContext logContext)
        {
            throw new NotImplementedException();
        }
    }
}
