using System;
using System.Net;
namespace PANVrf
{
    public class WebClientCookies : WebClient
    {
        private System.Net.CookieContainer container = new System.Net.CookieContainer();

        public WebClientCookies(System.Net.CookieContainer container)
        {
            this.container = container;
        }

        protected override WebRequest GetWebRequest(Uri address)
        {
            WebRequest webRequest = base.GetWebRequest(address);
            HttpWebRequest request2 = webRequest as HttpWebRequest;
            //if (request2 > null)
            //{
                request2.CookieContainer = this.container;
            //}
            return webRequest;
        }

        protected override WebResponse GetWebResponse(WebRequest request)
        {
            WebResponse webResponse = base.GetWebResponse(request);
            this.ReadCookies(webResponse);
            return webResponse;
        }

        protected override WebResponse GetWebResponse(WebRequest request, IAsyncResult result)
        {
            WebResponse webResponse = base.GetWebResponse(request, result);
            this.ReadCookies(webResponse);
            return webResponse;
        }

        private void ReadCookies(WebResponse r)
        {
            HttpWebResponse response = r as HttpWebResponse;
            //if (response > null)
            //{
                CookieCollection cookies = response.Cookies;
                this.container.Add(cookies);
            //}
        }

        public System.Net.CookieContainer CookieContainer
        {
            get
            {
                return this.container;
            }
            set
            {
                this.container = value;
            }
        }
    }

}