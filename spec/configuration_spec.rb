require "spec_helper"

describe XmlSpec::Configuration do

  it "excludes id and timestamps by default" do
    XmlSpec.excluded_keys.should == ["id", "created_at", "updated_at"]
  end

  it "excludes custom keys" do
    XmlSpec.exclude_keys("token")
    XmlSpec.excluded_keys.should == ["token"]
  end

  it "excludes custom keys via setter" do
    XmlSpec.excluded_keys = ["token"]
    XmlSpec.excluded_keys.should == ["token"]
  end

  it "excludes custom keys via block" do
    XmlSpec.configure{ |c| c.exclude_keys("token") }
    XmlSpec.excluded_keys.should == ["token"]
  end

  it "excludes custom keys via block setter" do
    XmlSpec.configure{ |c| c.excluded_keys = ["token"] }
    XmlSpec.excluded_keys.should == ["token"]
  end

  it "excludes custom keys via instance-evaluated block" do
    XmlSpec.configure{ exclude_keys("token") }
    XmlSpec.excluded_keys.should == ["token"]
  end

  it "ensures its excluded keys are strings" do
    XmlSpec.exclude_keys(:token)
    XmlSpec.excluded_keys.should == ["token"]
  end

  it "ensures its excluded keys are unique" do
    XmlSpec.exclude_keys("token", :token)
    XmlSpec.excluded_keys.should == ["token"]
  end

  it "resets its excluded keys" do
    original = XmlSpec.excluded_keys

    XmlSpec.exclude_keys("token")
    XmlSpec.excluded_keys.should_not == original

    XmlSpec.reset
    XmlSpec.excluded_keys.should == original
  end

  it "resets its directory" do
    XmlSpec.directory.should be_nil

    XmlSpec.directory = "/"
    XmlSpec.directory.should_not be_nil

    XmlSpec.reset
    XmlSpec.directory.should be_nil
  end

end
