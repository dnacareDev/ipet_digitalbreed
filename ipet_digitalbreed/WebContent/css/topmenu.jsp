<%
	String permissionUid = session.getAttribute("permissionUid")+"";
%>

	<script>
		function editprofile(){
			 //$("#popup_uploader").bPopup(); 
			 $('#editprofile').modal({ show: true });			
		}
	</script>

	<!-- edit profile Modal start-->
	    <div class="modal fade text-left" id="editprofile" tabindex="-1" role="dialog" aria-labelledby="myModalLabel4" aria-hidden="true">
	        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
	            <div class="modal-content">
             		<div class="modal-header bg-success white">
	                    <h4 class="modal-title" id="myModalLabel110">Modify User Profile</h4>
	                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                        <span aria-hidden="true">&times;</span>
	                    </button>
	                </div>
	                <div class="modal-body">
						<form novalidate>
						    <div class="row">
						        <div class="col-12">
						            <div class="form-group">
						                <div class="controls">
						                    <label for="account-username">Username=</label>
						                    <input type="text" class="form-control" id="account-username" placeholder="Username" value="<%=permissionUid%>" required data-validation-required-message="This username field is required" readonly>
						                </div>
						            </div>
						        </div>
						        <div class="col-12">
						            <div class="form-group">
							                <div class="controls">
							                    <label for="account-old-password">Old Password</label>
							                    <input type="password" class="form-control" id="account-old-password" required placeholder="Old Password" data-validation-required-message="This old password field is required">
							                </div>
							            </div>
							        </div>
							        <div class="col-12">
							            <div class="form-group">
							                <div class="controls">
							                    <label for="account-new-password">New Password</label>
							                    <input type="password" name="password" id="account-new-password" class="form-control" placeholder="New Password" required data-validation-required-message="The password field is required" minlength="6">
							                </div>
							            </div>
							        </div>
							        <div class="col-12">
							            <div class="form-group">
							                <div class="controls">
							                    <label for="account-retype-new-password">Retype New
							                        Password</label>
							                    <input type="password" name="con-password" class="form-control" required id="account-retype-new-password" data-validation-match-match="password" placeholder="New Password" data-validation-required-message="The Confirm password field is required" minlength="6">
							                </div>
							            </div>
							        </div>			
						        <div class="col-12">
						            <div class="form-group">
						                <div class="controls">
						                    <label for="account-name">Name</label>
						                    <input type="text" class="form-control" id="account-name" placeholder="Name" value="Hermione Granger" required data-validation-required-message="This name field is required">
						                </div>
						            </div>
						        </div>
						        <div class="col-12">
						            <div class="form-group">
						                <div class="controls">
						                    <label for="account-e-mail">E-mail</label>
						                    <input type="email" class="form-control" id="account-e-mail" placeholder="Email" value="granger007@hogward.com" required data-validation-required-message="This email field is required">
						                </div>
						            </div>
						        </div>
						        <div class="col-12">
						            <div class="form-group">
						                <label for="account-company">Company</label>
						                <input type="text" class="form-control" id="account-company" placeholder="Company name">
						            </div>
						        </div>
						        <div class="col-12 d-flex flex-sm-row flex-column justify-content-end">
						            <button type="submit" class="btn btn-primary mr-sm-1 mb-1 mb-sm-0">Save changes</button>
						            <button type="reset" class="btn btn-outline-warning">Cancel</button>
						        </div>
						    </div>
						</form>
	                </div>
	            </div>
	        </div>       
	    </div>                    
	<!-- edit profile Modal end-->
	    <!-- BEGIN: Header-->
    <nav class="header-navbar navbar-expand-lg navbar navbar-with-menu navbar-fixed navbar-shadow navbar-brand-center">
        <div class="navbar-wrapper">
            <div class="navbar-container content">
                <div class="navbar-collapse" id="navbar-mobile">
                    <div class="mr-auto float-left bookmark-wrapper d-flex align-items-center">
                        <ul class="nav navbar-nav">
                            <li class="nav-item mobile-menu d-xl-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ficon feather icon-menu"></i></a></li>
                        </ul>
			            <ul class="nav navbar-nav flex-row">
			                <li class="nav-item"><a class="navbar-brand" href="../mainboard.jsp">
									<img src="/ipet_digitalbreed/images/logo.png"><font size="4px"  color="#4c8aa9"><b>&nbsp;Digital Breeding</b></font>           
			                    </a></li>
			            </ul>
                    </div>
					<ul class="nav navbar-nav float-right">
					    <li class="dropdown dropdown-user nav-item"><a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
					            <div class="user-nav d-sm-flex d-none"><span class="user-name text-bold-600"><%=permissionUid%></span><span class="user-status">Available</span></div>
					        </a>
					        <div class="dropdown-menu dropdown-menu-right"><a class="dropdown-item" href="javascript:editprofile();"><i class="feather icon-user"></i> Edit Profile</a>
					            <div class="dropdown-divider"></div><a class="dropdown-item" href="/ipet_digitalbreed/web/public/logout.jsp"><i class="feather icon-power"></i> Logout</a>
					        </div>
					    </li>
					</ul>
                </div>
            </div>
        </div>
    </nav>
	