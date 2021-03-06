require 'spec_helper'

describe "accounts/edit.html.erb" do
  before(:each) do
    @account = assign(:account,
                      stub_model(Account,
                                 :application => 'value for application',
                                 :id => 'value for to_params'
                                 ))
  end

  it "renders the edit account form" do
    render

    assert_select "form", :action => account_path(@account), :method => "post" do
      assert_select "input#account_application", :application => "account[application]"
    end
  end
end
