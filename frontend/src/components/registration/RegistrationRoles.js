import React from 'react';
import { UserOutlined } from "@ant-design/icons";
import Radio from "antd/es/radio/radio";

const RegistrationRoles = ({setDisabledButton, disabledButton}) => {

    const onChangeHandle = (e) => {
        setDisabledButton(false)
        console.log(e.target.value)
    }

    return (
        <Radio.Group className="button-container"
                     onChange={onChangeHandle}
                     optionType="button"
                     buttonStyle="solid"
        >
            <Radio value="user">
                <div className="button-box">
                    <div className="ellipse"><UserOutlined className="user-icon"/></div>
                    Відвідувач
                </div>
            </Radio>
            <Radio value="owner">
                <div className="button-box">
                    <div className="ellipse"><UserOutlined className="user-icon"/></div>
                    Керівник
                </div>
            </Radio>
        </Radio.Group>
    )
}

export default RegistrationRoles
