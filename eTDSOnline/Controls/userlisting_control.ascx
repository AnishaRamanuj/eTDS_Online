﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="userlisting_control.ascx.cs" Inherits="controls_userlisting_control" %>

<script type="text/javascript" >
    function SearchCheck() {

        var name = document.getElementById("<%=txtsearch.ClientID%>");

        if (name.value == "search") {

            name.value = "";
            name.style.color = "#20556A";
            return false;
        }

    }
    function showsearch(item) {
        if (item.value == "") {
            item.value = "search";
        }
    }
</script>
<div id="divtotbody" class="totbodycatreg" style="overflow:hidden;border-top-style: solid; border-right-style: solid; border-left-style: solid; border-top-width: 1px; border-right-width: 1px; border-left-width: 1px; border-top-color: #55A0FF; border-right-color: #55A0FF; border-left-color: #55A0FF;width:1204px">
<div id="divtitl" class="totbodycatreg" style="overflow:hidden;width:1204px;">
<div style="overflow:hidden;width:878px; float:left; background-color: #55A0FF; margin-bottom: 8px; padding-bottom: 5px;">
   <img src="../images/13.png" style="overflow:hidden;height: 33px; width: 53px;" /><asp:Label 
           ID="Label23" runat="server" CssClass="labelebold" 
        Text="Company User Accounts"></asp:Label>
       </div>
<div style="overflow:hidden;width:1150px;float:left; padding-top: 10px; padding-left: 5px;">
<div style="overflow:hidden;width:15%; float:left;padding-right:10px;">
    <asp:Button ID="Button1" runat="server" Text="Create Company" CssClass="buttonstyle" Width="110px" onclick="Button1_Click" 
       />
</div>
<div style="overflow:hidden;width:15%;float:left;padding-top:3px" align="center">

    <asp:DropDownList ID="drpstatus" runat="server" Width="100px" CssClass="dropstyle">
        <asp:ListItem Selected >Active</asp:ListItem>
        <asp:ListItem>Suspended</asp:ListItem>
    </asp:DropDownList>
</div>
<%--<div style="overflow:hidden;width:18%;float:left">
<div style="overflow:hidden;width: 37px; float: left; padding-top: 0px;" align="left"><asp:Label ID="Label7" runat="server" Text="Role" CssClass="labelstyle"></asp:Label>
</div>
    <asp:DropDownList ID="drproles" runat="server" Width="109px" DataTextField="RoleName" DataValueField="RoleName" DataSourceID="SqlDataSourcerole" Height="23px">
    </asp:DropDownList>
       <asp:SqlDataSource ID="SqlDataSourcerole" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>">
       </asp:SqlDataSource>
</div>--%>
<div style="overflow:hidden;width:40%;float:left;padding-left:10px;padding-top:3px" align="center">

    <asp:DropDownList ID="drpusername" runat="server" Width="300px" 
        DataTextField="CompanyName" DataValueField="UserName" CssClass="dropstyle"
        DataSourceID="SqlDataSourceusrname" AppendDataBoundItems="True">
        <asp:ListItem Selected="True">--CompanyName--</asp:ListItem>
    </asp:DropDownList>
           <asp:SqlDataSource ID="SqlDataSourceusrname" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>">
       </asp:SqlDataSource>

</div>
<div style="overflow:hidden;width:20%;float:left;padding-top: 0px;" align="right">
<div style="overflow:hidden;width:85%;float:left;padding-top:3px">
    <asp:TextBox ID="txtsearch" runat="server" Width="129px" CssClass="txtnrml">search</asp:TextBox></div>
    <div style="overflow:hidden;width:14%;float:right;padding-top:3px"><asp:ImageButton ID="btnsearch"
        runat="server" ImageUrl="~/images/Search.gif" 
        Height="17px" Width="23px" ToolTip="Search" onclick="btnsearch_Click"
        /></div>
</div>
</div>

            <div style="overflow:hidden;padding-bottom: 0px; width: 1204px; float: left; padding-top: 10px;">
       
<asp:GridView ID="Griddealers" runat="server" AutoGenerateColumns="False" BorderColor="#55A0FF"
            Width="100%" DataSourceID="SqlDataSource1" DataKeyNames="UserId" 
               onrowcommand="Griddealers_RowCommand" AllowPaging="True" 
               onpageindexchanging="Griddealers_PageIndexChanging" 
                    EmptyDataText="No records found!!!">
            <RowStyle Height="30px" />
            <Columns>
           <%-- <asp:TemplateField HeaderText="Edit" HeaderStyle-CssClass="gridhaedstyle"> 
                    <ItemTemplate>
                        <div class="gridcolstyle" >
                            <asp:ImageButton ID="Button1" runat="server" CommandName="edit" 
                                ImageUrl="~/images/edit_f2.png" />
                        </div>
                    </ItemTemplate>                   
<HeaderStyle CssClass="gridhaedstyle"></HeaderStyle>                   
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                        <asp:ImageButton ID="btndelete" runat="server" 
                            CommandArgument='<%# bind("CompId") %>' onclick="btndelete_Click" onclientclick="javascript : return confirm('Are you sure want to delete?');"
                            ImageUrl="~/images/delete.gif" />
                    </ItemTemplate>
                    <HeaderStyle CssClass="gridhaedstyle" />
                </asp:TemplateField>--%>
            <asp:TemplateField HeaderText="dealerid" HeaderStyle-CssClass="gridhaedstyle" 
                    Visible="False">
                    <ItemTemplate>
                        <div class="gridcolstyle" style="overflow:hidden;word-wrap:break-word;" >
                            <asp:Label ID="lblfid" runat="server" CssClass="labelstyle" Text='<%# bind("UserId") %>'
                                ></asp:Label><asp:Label ID="Label1" runat="server" CssClass="labelstyle" Text='<%# bind("mastid") %>'
                                ></asp:Label>
                        </div>
                    </ItemTemplate>                  
  <HeaderStyle CssClass="grdheadermstertime" />               
                </asp:TemplateField>
              <asp:TemplateField HeaderText="Company Name" 
                    HeaderStyle-CssClass="gridhaedstyle">
                    <ItemTemplate>
                        <div class="gridcolstyle" style="overflow:hidden;word-wrap:break-word; width:300px;" >                            
                                 <%-- <asp:Label ID="Label2" runat="server" CssClass="labelstyle" 
                                Text='<%# bind("fullname") %>'></asp:Label>   --%>
                                  <asp:LinkButton ID="Label2" Text='<%# bind("fullname") %>' CssClass="grdLinks"
                                runat="server" CommandName="view"></asp:LinkButton>                      
                        </div>
                    </ItemTemplate>                  
  <HeaderStyle CssClass="grdheadermstertime" />                
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email">
                    <ItemTemplate>
                        <div class="gridcolstyle" style="overflow:hidden;word-wrap:break-word;width:200px;">
                            <asp:Label ID="Label3" runat="server" CssClass="labelstyle" 
                                Text='<%# bind("Emailid") %>'></asp:Label>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle CssClass="grdheadermstertime" />
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-CssClass="gridhaedstyle" 
                    HeaderText="Username">                  
                    <ItemTemplate>
                        <div class="gridcolstyle" style="overflow:hidden;word-wrap:break-word;">
                          <asp:LinkButton ID="lnkcmpName" Text='<%# bind("cUserName") %>' CssClass="grdLinks"
                                runat="server" CommandName="view"></asp:LinkButton>  
                          
                        </div>
                    </ItemTemplate>

  <HeaderStyle CssClass="grdheadermstertime" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Password">
                    <ItemTemplate>
                        <div class="gridcolstyle" style="overflow:hidden;word-wrap:break-word;">
                            <asp:Label ID="lblpassword" runat="server" CssClass="labelstyle" 
                                Text='<%# bind("cpassword") %>'></asp:Label>
                        </div>
                    </ItemTemplate>
                   <HeaderStyle CssClass="grdheadermstertime" />
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Multi-Co">
                    <ItemTemplate>
                        <div class="gridcolstyle" style="overflow:hidden;word-wrap:break-word;">
                            <asp:Label ID="Label4" runat="server" CssClass="labelstyle" 
                                Text='<%# bind("Sub_Companys") %>'></asp:Label>
                        </div>
                    </ItemTemplate>
                     <HeaderStyle CssClass="grdheadermstertime" />
                </asp:TemplateField>
             <asp:TemplateField HeaderText="Nos Of Comp">
                    <ItemTemplate>
                        <div class="gridcolstyle" style="overflow:hidden;word-wrap:break-word;">
                            <asp:Label ID="Label6" runat="server" CssClass="labelstyle" 
                                Text='<%# bind("Sub_Company_Count") %>'></asp:Label>
                        </div>
                    </ItemTemplate>
                     <HeaderStyle CssClass="grdheadermstertime" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="gridhaedstyle" />
        </asp:GridView>
        </div>
        <div id="div1" class="seperotorrwr"></div>   
<div id="griddiv" class="totbodycatreg">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ></asp:SqlDataSource>
    </div>
</div>   
</div>