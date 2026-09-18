import React from 'react';
import { UserOutlined } from "@ant-design/icons";
import { Radio } from "antd";

const RegistrationRoles = ({ setDisabledButton }) => {

    const onChangeHandle = (e) => {
        setDisabledButton(false);
        console.log(e.target.value);
    };

    return (
        <Radio.Group
            className="button-container"
            onChange={onChangeHandle}
            buttonStyle="solid"
        >
            <Radio.Button value="user" className="ant-radio-button-wrapper">
                <div className="button-box">
                    <div className="ellipse">
                        <UserOutlined className="user-icon"/>
                    </div>
                    Відвідувач
                </div>
            </Radio.Button>

            <Radio.Button value="owner" className="ant-radio-button-wrapper">
                <div className="button-box">
                    <div className="ellipse">
                        <UserOutlined className="user-icon"/>
                    </div>
                    Керівник
                </div>
            </Radio.Button>
        </Radio.Group>
    );
};

export default RegistrationRoles;

